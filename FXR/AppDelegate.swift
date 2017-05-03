//
//  AppDelegate.swift
//  iFXCT
//
//  Created by Tobey Unruh on 1/19/16.
//  Copyright © 2016 Tobey Unruh. All rights reserved.
//

import Cocoa

typealias ValuePath = (path: String, tag: String?, value: String?)
//typealias SoapElement = (path: String, elements: [String], count: Int, parent: String, tag: String, value: String, service: String)

struct Stack<Element> {
	var items = [Element]()
	
	mutating func push(_ item: Element) {
		items.append(item)
	}
	
	mutating func pop() -> Element {
		return items.removeLast()
	}
}

extension Stack {
	var peek: Element? {
		return items.isEmpty ? nil : items[items.count - 1]
	}
	
	var parent: Element? {
		return items.isEmpty ? nil : items[items.count - 2]
	}
	
	var xpath: Element? {
		return items.isEmpty ? nil : items.map{ String(describing: $0) }.joined(separator: "|") as? Element
	}
	
	func find(_ search: String) -> [Element] {
		return items.filter{ ($0 is String) ? String(describing: $0).contains(search) : ($0 as! ValuePath).path.contains(search) }
	}
	
	func filter2(_ depthEqualTo: Int) -> [Element]
	{
		var arr: [Element] = [Element]()
			
		items.forEach{ soapElement in
			if (soapElement as! SoapElement).depth == depthEqualTo {
				arr.append(soapElement)
			}
		}
		
		return arr
	}
	
	func indexOf(search: String, start: Int) -> Int {
		if let i = items.index(where: { String(describing: $0).contains(search) && items.index(after: start) >= start }) {
			return i
		}
		else
		{
			return -1
		}
	}
	
	func unique() -> [String] {
		return Set(items.map{ ($0 as! ValuePath).path.components(separatedBy: "|").dropLast().joined(separator: "|") })
			.sorted(by: { $0.0.components(separatedBy: "|").count < $0.1.components(separatedBy: "|").count })
	}
	
	func subrange(_ index: Int) -> [String] {
		return Set(items.map{ ($0 as! ValuePath).path.components(separatedBy: "|")[index] }).sorted(by: <)
	}
	
	func getPathFromChild(_ value: String) -> Element? {
		return items.filter{ ($0 as! ValuePath).path.components(separatedBy: "|").dropLast().last == value }.last
	}
}

struct SoapElement
{
	let id: Int
	let path: String
	let elements: Array<String>
	let depth: Int
	let parent: Int?
	let tag: String
	let value: String?
}

extension Array where Element == ValuePath
{
	func getValue(service: String, value: String) -> String?
	{
		return filter { $0.tag == service && $0.path.contains(value) }.last?.value
	}
}

extension Collection where Indices.Iterator.Element == Index {
	
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	subscript (safe index: Index) -> Generator.Element? {
		return indices.contains(index) ? self[index] : nil
	}
}

extension String {
	func toDate() -> Date? {
		let df = DateFormatter(); df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		
		return df.date(from: self) ?? nil
	}
}

extension String {
	func toCurrency() -> String? {
		let nf = NumberFormatter(); nf.locale = Locale(identifier: Locale.current.identifier); nf.numberStyle = .currency
		
		return nf.string(from: NSNumber(value: Float(self)!)) ?? nil
	}
}

extension AppDelegate {
	func isFreight() -> Bool {
		guard let _ = lineItems.items.first as? FreightShipmentLineItem else {
			return false
		}
		
		return true
	}
}

@NSApplicationMain
class AppDelegate: NSObject
{
	// app outlets
	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var addPackageLineItemButton: NSButton!
	@IBOutlet weak var addFreightLineItemButton: NSButton!
	@IBOutlet weak var progressIndicator: NSProgressIndicator!
	@IBOutlet weak var senderZip: NSTextField!
	@IBOutlet weak var recipientZip: NSTextField!
	@IBOutlet weak var packageWeight: NSTextField!
	@IBOutlet weak var httpResponseLabel: NSTextField!
	@IBOutlet weak var trackingNumber: NSTextField!
	@IBOutlet weak var detailsView: NSOutlineView!
	@IBOutlet weak var specialServicesTable: NSTableView!
	@IBOutlet weak var packageLength: NSTextField!
	@IBOutlet weak var packageWidth: NSTextField!
	@IBOutlet weak var packageHeight: NSTextField!
	@IBOutlet weak var packageLinearUnits: NSPopUpButton!
	@IBOutlet weak var freightClassPopUp: NSPopUpButton!
	@IBOutlet weak var freightPkgTypePopUp: NSPopUpButton!
	@IBOutlet weak var freightQuantity: NSTextField!
	@IBOutlet weak var freightVolume: NSTextField!
	@IBOutlet weak var residentialCheck: NSButton!
	@IBOutlet weak var lineItemsTable: NSTableView!
	@IBOutlet weak var linearUnitsPopUp: NSPopUpButton!
	@IBOutlet weak var freightVolumeUnitsPopUp: NSPopUpButton!
	@IBOutlet weak var freightItemWeight: NSTextField!
	@IBOutlet weak var freightItemLength: NSTextField!
	@IBOutlet weak var freightItemWidth: NSTextField!
	@IBOutlet weak var freightItemHeight: NSTextField!
	@IBOutlet weak var itemDetailTabView: NSTabView!
	
	// local vars
	var cityState = (city: "", state: "", zip: "")
	var xmlParser = XMLParser()
	var pathStack = Stack<String>()
	var soapStack = Stack<SoapElement>()
	var parentStack = Stack<SoapElement>()
	var currentId: Int? = nil
	var lineItems = Stack<Any>()
	
	@IBAction func OpenPreferences(_ sender: Any) {
		DispatchQueue.main.async(execute: { () -> Void in
			NSApplication.shared().runModal(for: SettingsController().window!)
		})
	}
	
	@IBAction func ViewEULA(_ sender: Any) {
		DispatchQueue.main.async(execute: { () -> Void in
			NSApplication.shared().runModal(for: EulaController().window!)
		})
	}
	
	@IBAction func deleteLineItem(_ sender: Any) {
		guard lineItemsTable.selectedRow >= 0 else { return }

		lineItems.items.remove(at: lineItemsTable.selectedRow)
		
		if (lineItems.items.count == 0) {
			lineItemsTable.tableColumns[0].title = ""
			
			parentStack.items.removeAll()
			soapStack.items.removeAll()
			
			detailsView.reloadData()
		}
		
		lineItemsTable.reloadData()
	}
	
	@IBAction func addPackageLineItemButton(_ sender: Any) {
		guard let x = Int(packageWeight.stringValue), x > 0 else { return }
		
		addPackageLineItem()
		
		lineItemsTable.tableColumns[0].title = "PARCEL"
		lineItemsTable.reloadData()
	}
	
	func addPackageLineItem()
	{
		if (lineItems.items.first is FreightShipmentLineItem) { lineItems.items.removeAll() }
		
		lineItems.items.append(RequestedPackageLineItem(
			sequenceNumber: 1,
			groupNumber: 1,
			groupPackageCount: 1,
			variableHandlingChargeDetail: nil,
			insuredValue: nil,
			weight: Weight(units: WeightUnits.LB, value: Float(packageWeight.stringValue)!),
			dimensions: Dimensions(
				length: Int(packageLength.stringValue),
				width: Int(packageWidth.stringValue),
				height: Int(packageHeight.stringValue),
				units: LinearUnits(rawValue: packageLinearUnits.titleOfSelectedItem)
			),
			physicalPackaging: PhysicalPackagingType.BOX,
			itemDescription: nil,
			itemDescriptionForClearance: nil,
			customerReferences: nil,
			specialServicesRequested: PackageSpecialServicesRequested(
				specialServiceTypes: specialServicesTable.selectedRowIndexes.map{ PackageSpecialServiceType(rawValue: PackageSpecialServiceType.values[$0])! },
				codDetail: nil, //CodDetail?,
				dangerousGoodsDetail: nil, //DangerousGoodsDetail?,
				dryIceWeight: nil, //Weight?,
				signatureOptionDetail: nil, //SignatureOptionDetail?,
				priorityAlertDetail: nil, //PriorityAlertDetail?,
				alcoholDetail: nil //AlcoholDetail?),
			),
			contentRecords: nil
			)
		)
		
		specialServicesTable.deselectAll(nil)
		packageWeight.stringValue = ""
		packageWidth.stringValue = ""
		packageHeight.stringValue = ""
		packageLength.stringValue = ""
		packageLinearUnits.selectItem(withTitle: "IN")
	}
	
	@IBAction func addFreightLineItemButton(_ sender: Any) {
		guard let x = Int(freightItemWeight.stringValue), x > 0 else { return }
		
		addFreightLineItem()
		
		lineItemsTable.tableColumns[0].title = "FREIGHT"
		lineItemsTable.reloadData()
	}
	
	func addFreightLineItem()
	{
		if (lineItems.items.first is RequestedPackageLineItem) { lineItems.items.removeAll() }
		
		lineItems.items.append(FreightShipmentLineItem(
			freightClass: FreightClassType(rawValue: freightClassPopUp.titleOfSelectedItem!),
			packaging: PhysicalPackagingType(rawValue: freightPkgTypePopUp.titleOfSelectedItem!),
			pieces: UInt(freightQuantity.stringValue) ?? 0,
			description: nil,
			weight: Weight(units: WeightUnits.LB, value: Float(freightItemWeight.stringValue) ?? 0),
			dimensions: Dimensions(
				length: Int(freightItemLength.stringValue),
				width: Int(freightItemWidth.stringValue),
				height: Int(freightItemHeight.stringValue),
				units: LinearUnits(rawValue: linearUnitsPopUp.titleOfSelectedItem)
			),
			volume: Volume(units: VolumeUnits(rawValue: freightVolumeUnitsPopUp.titleOfSelectedItem), value: Float(freightVolume.stringValue) ?? 0))
		)
		
		freightClassPopUp.selectItem(at: 0)
		freightPkgTypePopUp.selectItem(at: 0)
		freightQuantity.stringValue = ""
		freightVolume.stringValue = ""
		freightItemWeight.stringValue = ""
		freightItemWidth.stringValue = ""
		freightItemHeight.stringValue = ""
		freightItemLength.stringValue = ""
		linearUnitsPopUp.selectItem(withTitle: "IN")
		freightVolumeUnitsPopUp.selectItem(withTitle: "Cubic FT")
	}
	
//	@IBAction func freightDisclosure(_ sender: NSButton) {
//		var windowFrame = window.frame
//		
//		outlineViewTopConstraint.isActive = (sender.state == 0)
//		lineItemTableBottomConstraint.isActive = (sender.state == 1)
//		
//		let toAdd = CGFloat(100) * ((sender.state == 1) ? 1 : -1)
//		
//		let oldWidth = windowFrame.size.width
//		let oldHeight = windowFrame.size.height
//		
//		let newWidth = oldWidth // + toAdd
//		let newHeight = oldHeight + toAdd
//		
//		windowFrame.size = NSMakeSize(newWidth, newHeight)
//		windowFrame.origin.y -= toAdd
//		
//		window.setFrame(windowFrame, display: true, animate: true)
//		
//		outlineViewTopConstraint.animator().constant += toAdd
//	}
	
	@IBAction func quickTrack(_ sender: Any)
	{
		let soapMessage = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v12=\"http://fedex.com/ws/track/v12\"><soapenv:Header> </soapenv:Header>" +
			"<soapenv:Body>" +
			"<v12:TrackRequest>" +
			"<v12:WebAuthenticationDetail>" +
			"<v12:UserCredential>" +
			"<v12:Key>\(KeychainManager.queryData(itemKey: "key") as? String ?? "")</v12:Key>" +
			"<v12:Password>\(KeychainManager.queryData(itemKey: "password") as? String ?? "")</v12:Password>" +
			"</v12:UserCredential>" +
			"</v12:WebAuthenticationDetail>" +
			"<v12:ClientDetail>" +
			"<v12:AccountNumber>\(KeychainManager.queryData(itemKey: "account") as? String ?? "")</v12:AccountNumber>" +
			"<v12:MeterNumber>\(KeychainManager.queryData(itemKey: "meter") as? String ?? "")</v12:MeterNumber>" +
			"<v12:Localization>" +
			"<v12:LanguageCode>EN</v12:LanguageCode>" +
			"<v12:LocaleCode>us</v12:LocaleCode>" +
			"</v12:Localization>" +
			"</v12:ClientDetail>" +
			"<v12:TransactionDetail>" +
			"<v12:CustomerTransactionId>Track By Number_v12</v12:CustomerTransactionId>" +
			"</v12:TransactionDetail>" +
			"<v12:Version>" +
			"<v12:ServiceId>trck</v12:ServiceId>" +
			"<v12:Major>12</v12:Major>" +
			"<v12:Intermediate>0</v12:Intermediate>" +
			"<v12:Minor>0</v12:Minor>" +
			"</v12:Version>" +
			"<v12:SelectionDetails>" +
			"<v12:PackageIdentifier>" +
			"<v12:Type>TRACKING_NUMBER_OR_DOORTAG</v12:Type>" +
			"<v12:Value>\(trackingNumber.stringValue)</v12:Value>" +
			"</v12:PackageIdentifier>" +
			"</v12:SelectionDetails>" +
			"</v12:TrackRequest>" +
			"</soapenv:Body>" +
		"</soapenv:Envelope>"
		
		callDataTask(body: soapMessage)
	}
	
	func rateShipment()
	{
		let rpli: [RequestedPackageLineItem]?
		let fsd: FreightShipmentDetail?
		
		if (lineItems.items.count == 0) { return }
		
		let wad = WebAuthenticationDetail(
			parentCredential: nil,
			userCredential: WebAuthenticationCredential(
				key: KeychainManager.queryData(itemKey: "key") as? String ?? "",
				password: KeychainManager.queryData(itemKey: "password") as? String ?? "")
		)
		
		let cd = ClientDetail(
			accountNumber: KeychainManager.queryData(itemKey: "account") as? String ?? "",
			meterNumber: KeychainManager.queryData(itemKey: "meter") as? String ?? "",
			integratorId: nil,
			region: nil,
			localization: nil)
		
		if isFreight() {
			fsd = FreightShipmentDetail(
				fedExFreightAccountNumber: KeychainManager.queryData(itemKey: "ltlaccount") as? String ?? "",
				fedExFreightBillingContactAndAddress: ContactAndAddress(
					contact: nil,
					address: Address(
						streetLines: UserDefaults.standard.string(forKey: "ltladdress"),
						city: UserDefaults.standard.string(forKey: "ltlcity"),
						stateOrProvinceCode: UserDefaults.standard.string(forKey: "ltlstate"),
						postalCode: UserDefaults.standard.string(forKey: "ltlzip"),
						urbanizationCode: nil,
						countryCode: "US",
						countryName: nil,
						residential: false
					)
				),
				alternateBilling: nil,
				role: FreightShipmentRoleType(rawValue: (UserDefaults.standard.integer(forKey: "ltlthirdparty") == 0 ? "SHIPPER" : "CONSIGNEE")),
				collectTermsType: FreightCollectTermsType.STANDARD,
				declaredValuePerUnit: nil, //Money?,
				declaredValueUnits: nil, //String?,
				liabilityCoverageDetail: nil, //LiabilityCoverageDetail?,
				coupons: nil, //String?,
				totalHandlingUnits: nil, //UInt?,
				clientDiscountPercent: nil, //Decimal?,
				palletWeight: nil,
				shipmentDimensions: nil, //Dimensions?,
				comment: nil, //String?,
				specialServicePayments: nil, //FreightSpecialServicePayment?,
				hazardousMaterialsOfferor: nil, //String?,
				lineItems: lineItems.items as! [FreightShipmentLineItem]
			)
			
			rpli = nil
		} else {
			rpli = lineItems.items as? [RequestedPackageLineItem]
			
			fsd = nil
		}
		
		let web = RateRequest(
			webAuthenticationDetail: wad,
			clientDetail: cd,
			transactionDetail: TransactionDetail(customerTransactionId: "FXR TEST", localization: nil),
			returnTransAndCommit: true,
			carrierCodes: nil,
			variableOptions: nil,
			consolidationKey: nil,
			requestedShipment: RequestedShipment(
				shipTimestamp: Date(), //.addingTimeInterval(86400),
				dropoffType: DropoffType.REGULAR_PICKUP,
				serviceType: nil, //ServiceType.GROUND_HOME_DELIVERY,
				packagingType: PackagingType.YOUR_PACKAGING,
				variationOptions: nil,
				totalWeight: Weight(units: WeightUnits.LB, value: getTotalWeight()),
				totalInsuredValue: nil,
				preferredCurrency: nil,
				shipmentAuthorizationDetail: nil,
				shipper: getParty(),
				recipient: Party(
					accountNumber: nil,
					tins: nil,
					contact: nil,
					address: Address(
						streetLines: nil,
						city: cityState.city,
						stateOrProvinceCode: cityState.state,
						postalCode: recipientZip.stringValue,
						urbanizationCode: nil,
						countryCode: "US",
						countryName: nil,
						residential: residentialCheck.state == 1)
				),
				recipientLocationNumber: nil,
				origin: nil,
				soldTo: nil,
				shippingChargesPayment: Payment(
					paymentType: PaymentType.SENDER,
					payor: Payor(responsibleParty: getParty())
				),
				specialServicesRequested: nil,
				expressFreightDetail: nil,
				freightShipmentDetail: fsd,
				deliveryInstructions: nil,
				variableHandlingChargeDetail: nil,
				customsClearanceDetail: nil,
				pickupDetail: nil,
				smartPostDetail: nil,
				blockInsightVisibility: false,
				labelSpecification: nil,
				shippingDocumentSpecification: nil,
				rateRequestTypes: RateRequestType.LIST,
				edtRequestType: EdtRequestType.NONE,
				packageCount: lineItems.items.count,
				shipmentOnlyFields: ShipmentOnlyFieldsType.WEIGHT,
				configurationData: nil,
				requestedPackageLineItems: rpli
			)
		)
		
		//print("\(web)")
		callDataTask(body: "\(web)")
	}
	
	override func controlTextDidEndEditing(_ obj: Notification) {
		guard let tf = obj.object as? NSTextField else { return }
		
		if tf.identifier == "RecipientZipTextField" {
			if recipientZip.stringValue.characters.count == 5 {
				getCityStateFromUSPS(recipientZip.stringValue)
			}
		}
	}
	
	func getCityStateFromUSPS(_ zip: String)
	{
		let web = "&XML=<CityStateLookupRequest USERID=\"829TOBEY1118\">" +
					"<ZipCode ID=\"0\">" +
					"<Zip5>\(zip)</Zip5>" +
					"</ZipCode>" +
					"</CityStateLookupRequest>"
		
		let task = URLSession.shared.dataTask(with: getUrlRequest(body: web, url2: "https://secure.shippingapis.com/ShippingAPI.dll?API=CityStateLookup"), completionHandler: completionCallback)

		task.resume()
	}
	
	func getTotalWeight() -> Float
	{
		if isFreight() {
			return (lineItems.items as! [FreightShipmentLineItem]).reduce(Float(0), { $0 + $1._weight!._value! })
		} else {
			return (lineItems.items as! [RequestedPackageLineItem]).reduce(Float(0), { $0 + $1._weight!._value! })
		}
	}
	
	func getParty() -> Party
	{
		let pfx = (isFreight() ? "ltl" : "")
		
		return Party(
			accountNumber: KeychainManager.queryData(itemKey: "\(pfx)account") as? String ?? "",
			tins: nil,
			contact: nil,
			address: Address(
				streetLines: UserDefaults.standard.string(forKey: "\(pfx)address"),
				city: UserDefaults.standard.string(forKey: "\(pfx)city"),
				stateOrProvinceCode: UserDefaults.standard.string(forKey: "\(pfx)state"),
				postalCode: UserDefaults.standard.string(forKey: "\(pfx)zip"),
				urbanizationCode: nil,
				countryCode: "US",
				countryName: nil,
				residential: false
			)
		)
	}
	
	func getUrlRequest(body: String) -> URLRequest
	{
		var request = URLRequest(url: URL(string: UserDefaults.standard.string(forKey: "ws-url")!)!)
		
		request.httpMethod = "POST"
		request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
		request.httpBody = body.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
		
		return request
	}
	
	func getUrlRequest(body: String, url2: String) -> URLRequest
	{
		var request = URLRequest(url: URL(string: url2)!)
		
		request.httpMethod = "POST"
		request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
		request.httpBody = body.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
		
		return request
	}
	
	func callDataTask(body: String)
	{
		DispatchQueue.main.async(execute: { () -> Void in
			self.progressIndicator.startAnimation(self)
			
			// disable delete
			NSApp.mainMenu?.item(withTitle: "Edit")?.submenu?.item(withTitle: "Delete")?.isEnabled = false
			self.addPackageLineItemButton.isEnabled = false
			self.addFreightLineItemButton.isEnabled = false
		})
		
		let task = URLSession.shared.dataTask(with: getUrlRequest(body: body), completionHandler: completionCallback)
		
		task.resume()
	}
	
	func completionCallback(data2: Data?, response: URLResponse?, error: Error?)
	{
		guard let _:Data = data2, let _:URLResponse = response, error == nil else
		{
			if error != nil
			{
				print("error: \(error!.localizedDescription)")
			}
			
			return
		}
		
		//print(NSString(data: data2!, encoding: String.Encoding.utf8.rawValue) ?? "")
		
		let httpResponse = response as? HTTPURLResponse
		
		DispatchQueue.main.async(execute: { () -> Void in
			self.httpResponseLabel.stringValue = "Status: \(httpResponse!.statusCode)"
		})
		
		if (httpResponse?.statusCode == 200)
		{
			let start = CFAbsoluteTimeGetCurrent()
			
			// reset stack vars
			pathStack = Stack<String>()
			soapStack = Stack<SoapElement>()
			parentStack = Stack<SoapElement>()
			
			// init parser
			self.xmlParser = XMLParser(data: data2!)
			self.xmlParser.delegate = self
			self.xmlParser.shouldResolveExternalEntities = true;
			self.xmlParser.parse()
			
			// enable delete
			DispatchQueue.main.async(execute: { () -> Void in
				//self.deleteMenu.isEnabled = true
				self.addPackageLineItemButton.isEnabled = true
				self.addFreightLineItemButton.isEnabled = true
			})
			
			print("\(CFAbsoluteTimeGetCurrent() - start)")
		}
	}
}

extension AppDelegate: NSApplicationDelegate
{
	func applicationWillFinishLaunching(_ notification: Notification)
	{
		if let _ = KeychainManager.queryData(itemKey: "eula") {
			return
		}
		
		NSApplication.shared().runModal(for: EulaController().window!)
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification)
	{
		// Insert code here to initialize your application
		
		senderZip.stringValue = "\((UserDefaults.standard.string(forKey: "zip")) ?? "")"
		
		currentId = nil
		
		lineItemsTable.delegate = self
		lineItemsTable.dataSource = self
		lineItemsTable.target = self
		lineItemsTable.reloadData()
		lineItemsTable.doubleAction = #selector(tableViewDoubleClick(_:))
		
		detailsView.delegate = self
		detailsView.dataSource = self
		detailsView.reloadData()
		
		specialServicesTable.delegate = self
		specialServicesTable.dataSource = self
		specialServicesTable.reloadData()
		
		freightClassPopUp.addItems(withTitles: FreightClassType.values)
		freightPkgTypePopUp.addItems(withTitles: PhysicalPackagingType.values)
		freightVolumeUnitsPopUp.addItems(withTitles: VolumeUnits.values)
		packageLinearUnits.addItems(withTitles: LinearUnits.values)
		linearUnitsPopUp.addItems(withTitles: LinearUnits.values)
		
		packageLinearUnits.selectItem(withTitle: "IN")
		linearUnitsPopUp.selectItem(withTitle: "IN")
		freightVolumeUnitsPopUp.selectItem(withTitle: "Cubic FT")
		
		UserDefaults.standard.set(1, forKey: "NSInitialToolTipDelay")
	}
	
	func applicationWillTerminate(_ aNotification: Notification)
	{
		// Insert code here to tear down your application
	}
	
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool
	{
		return true
	}
}

extension AppDelegate: XMLParserDelegate
{
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
	{
		// ignore SOAP headers
		if (elementName.contains("SOAP-ENV")) { return }
		
		// store opening tag
		pathStack.push(elementName)
		
		if soapStack.items.count == 0 {
			currentId = nil
		} else if (pathStack.xpath!.components(separatedBy: "|").count > (soapStack.items.last?.depth)!) {
			currentId = (parentStack.items.last?.id)!
		} else if (pathStack.xpath!.components(separatedBy: "|").count < (soapStack.items.last?.depth)!) {
			currentId = (parentStack.filter2(pathStack.xpath!.components(separatedBy: "|").count - 1).last?.id)
		}
		
		parentStack.push(
			SoapElement(
				id: soapStack.items.count,
				path: pathStack.xpath!,
				elements: pathStack.xpath!.components(separatedBy: "|"),
				depth: pathStack.xpath!.components(separatedBy: "|").count,
				parent: currentId,
				tag: elementName,
				value: nil
			)
		)
		
		soapStack.push(parentStack.items.last!)
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String)
	{
		if (string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "") { return }
		
		// remove header for value elements
		if pathStack.xpath! == soapStack.items.last!.path {
			let _ = soapStack.pop()
			let _ = parentStack.pop()
		}
		
		soapStack.push(SoapElement(id: soapStack.items.count,
		                           path: pathStack.xpath!,
		                           elements: pathStack.xpath!.components(separatedBy: "|"),
		                           depth: pathStack.xpath!.components(separatedBy: "|").count,
		                           parent: currentId,
		                           tag: pathStack.xpath!.components(separatedBy: "|").last!,
		                           value: string)
		)
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
	{
		// remove tag to back out of path
		if (pathStack.peek == elementName)
		{
			// pop and ignore return
			let _ = pathStack.pop()
		}
	}
	
	func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
	{
		
	}
	
	func parserDidEndDocument(_ parser: XMLParser)
	{
//		print("\(self.soapStack)")
//		print("\(self.soapStack.items.filter{ $0.value == nil })")
		
		DispatchQueue.main.async(execute: { () -> Void in
			//self.detailsTable.reloadData()
			self.detailsView.reloadData()
			self.httpResponseLabel.stringValue = "Status: Parsing Complete"
			
			self.detailsView.expandItem(self.detailsView.item(atRow: 0), expandChildren: false)
			self.detailsView.becomeFirstResponder()
			
			self.progressIndicator.stopAnimation(self)
			
			//if self.soapStack.items.count > 0 {
				if self.soapStack.items.first?.tag == "CityStateLookupResponse" {
					self.cityState.zip = (self.soapStack.items.filter{ $0.tag == "Zip5" }.first?.value!)!
					self.cityState.city = (self.soapStack.items.filter{ $0.tag == "City" }.first?.value!)!
					self.cityState.state = (self.soapStack.items.filter{ $0.tag == "State" }.first?.value)!
					
					self.detailsView.tableColumns[0].title = "Name - \(self.cityState.city), \(self.cityState.state)"
				}
			//}
		})
	}
}

extension AppDelegate: NSTableViewDataSource
{
	func numberOfRows(in tableView: NSTableView) -> Int
	{
		// trigger when line items are added
		if (tableView.identifier == "LineItemsTable") {
			rateShipment()
		}
		
		if (tableView.identifier == "LineItemsTable") {
			return lineItems.items.count
		}
		
		if (tableView.identifier == "SpecialServicesTable") {
			return PackageSpecialServiceType.values.count
		}
		
		return 0
	}
}

extension AppDelegate: NSTableViewDelegate
{
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
	{
		if (tableView.identifier == "LineItemsTable") {
			if (tableColumn?.identifier == "ValueColumn") {
				// get record to display
				if let lineItem = lineItems.items[row] as? FreightShipmentLineItem {
					return "\(lineItem._weight!._value!) \(lineItem._weight!._units!)"
				}
				
				if let lineItem = lineItems.items[row] as? RequestedPackageLineItem {
					return "\(lineItem._weight!._value!) \(lineItem._weight!._units!)"
				}
			}
		}
		
		if (tableView.identifier == "SpecialServicesTable") {
			return PackageSpecialServiceType.values[row]
		}
		
		return nil
	}
	
	func tableViewDoubleClick(_ sender: AnyObject)
	{
//		guard lineItemsTable.selectedRow >= 0,
//			let item = lineItems.items[lineItemsTable.selectedRow] as? FreightShipmentLineItem else {
//			
//				return
//		}
	}
}

extension AppDelegate: NSOutlineViewDelegate
{
	func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any?
	{
		// if item is nil, empty view (i.e. init)
		guard let soapElement = item as? SoapElement else  { return nil }

		// if NameColumn
		if tableColumn?.identifier == "NameColumn" {
			return soapElement.tag
		} else if tableColumn?.identifier == "ValueColumn" {
			if soapElement.tag == "RateReplyDetails" {
				return soapStack.items.filter{ $0.parent == soapElement.id && $0.tag == "ServiceType" }.last?.value
			}
			
			if (soapElement.tag == "Notifications") {
				return soapStack.items.filter{ $0.parent == soapElement.id && $0.tag == "Message" }.last?.value
			}
			
			if (soapElement.tag == "CompletedTrackDetails") {
				outlineView.selectRowIndexes(IndexSet(integer: 5), byExtendingSelection: false)
				outlineView.expandItem(item)
		
				return drillDown(parent: soapElement, path: "TrackDetails|StatusDetail|Description")?.value
			}
			
			return soapElement.value
		} else if tableColumn?.identifier == "CostColumn" {
			if soapElement.tag == "RateReplyDetails" {
				return drillDown(parent: soapElement, path: "RatedShipmentDetails|ShipmentRateDetail|TotalNetCharge|Amount")?.value?.toCurrency() ?? "0".toCurrency()
			}
		} else if tableColumn?.identifier == "CommitColumn" {
			if soapElement.tag == "RateReplyDetails" {
				guard let x = drillDown(parent: soapElement, path: "CommitDetails|DayOfWeek")?.value! else {
					return drillDown(parent: soapElement, path: "CommitDetails|TransitTime")?.value!
				}
				
				return x
			}
		}
		
		return nil
	}
	
	func drillDown(parent: SoapElement, path: String) -> SoapElement? {
//		print(parent)
//		print(path)
		
		if path.components(separatedBy: "|").count > 1 {
			return drillDown(
				parent: soapStack.items
					.filter{ $0.parent == parent.id }
					.filter{ $0.tag == path.components(separatedBy: "|").first! }.first!,
				path: (path.components(separatedBy: "|").dropFirst().joined(separator: "|"))
			)
		}
		
		return soapStack.items.filter{ $0.parent == parent.id && $0.tag == path.components(separatedBy: "|").last! }.last
	}
}

extension AppDelegate: NSOutlineViewDataSource
{
	func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool
	{
		// if has children, return true
		return parentStack.items.filter{ $0.id == (item as? SoapElement)!.id }.count > 0
	}
	
	func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
	{
		// if stack is empty, return 0 (i.e. init)
		if (soapStack.items.count == 0) { return 0 }
		
		// if item is nil, return 1 (i.e. root)
		guard let soapElement = item as? SoapElement else { return 1 }
		
		// else return number of children
		return soapStack.items.filter{ $0.parent == soapElement.id }.count
	}
	
	func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any
	{
		// if item is nil, return root element
		guard let soapElement = item as? SoapElement else {
			return soapStack.items.first!
		}
		
		// else return child elements
		return soapStack.items.filter{ $0.parent == soapElement.id }[index]
	}
}

extension AppDelegate: NSComboBoxDelegate, NSComboBoxDataSource
{
	func numberOfItems(in comboBox: NSComboBox) -> Int {
		return PackageSpecialServiceType.values.count
	}
	
	func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
		return PackageSpecialServiceType.values[index]
	}
}
