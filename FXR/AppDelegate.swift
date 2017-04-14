//
//  AppDelegate.swift
//  iFXCT
//
//  Created by Tobey Unruh on 1/19/16.
//  Copyright © 2016 Tobey Unruh. All rights reserved.
//

import Cocoa

typealias ValuePath = (path: String, tag: String?, value: String?)

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
	
	func indexOf(search: String, start: Int) -> Int {
		if let i = items.index(where: { String(describing: $0).contains(search) && items.index(after: start) >= start }) {
			return i
		}
		else
		{
			return -1
		}
	}
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

@NSApplicationMain
class AppDelegate: NSObject
{
	// app outlets
	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var detailsTable: NSTableView!
	@IBOutlet weak var progressIndicator: NSProgressIndicator!
	@IBOutlet weak var senderZip: NSTextField!
	@IBOutlet weak var recipientZip: NSTextField!
	@IBOutlet weak var packageWeight: NSTextField!
	@IBOutlet weak var httpResponseLabel: NSTextField!
	@IBOutlet weak var showRawXml: NSButton!
	@IBOutlet weak var detailsView: NSOutlineView!
	
	//var rateRequest: RateRequest
	var xmlParser = XMLParser()
	var pathStack = Stack<String>()
	var valueStack = Stack<ValuePath>()
	var rateReply: RateReply
	var service: String
	
	override init()
	{
		rateReply = RateReply(valueStack)
		service = String()
	}
	
	@IBAction func quickTrack(_ sender: Any)
	{
//		let soapMessage = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v12=\"http://fedex.com/ws/track/v12\"><soapenv:Header> </soapenv:Header>" +
//			"<soapenv:Body>" +
//			"<v12:TrackRequest>" +
//			"<v12:WebAuthenticationDetail>" +
//			"<v12:UserCredential>" +
//			"<v12:Key>ATjhnRZwKmclwko3</v12:Key>" +
//			"<v12:Password>yrsrYK0DeXj6RbbKrn51p8f8O</v12:Password>" +
//			"</v12:UserCredential>" +
//			"</v12:WebAuthenticationDetail>" +
//			"<v12:ClientDetail>" +
//			"<v12:AccountNumber>510087100</v12:AccountNumber>" +
//			"<v12:MeterNumber>118784833</v12:MeterNumber>" +
//			"<v12:Localization>" +
//			"<v12:LanguageCode>EN</v12:LanguageCode>" +
//			"<v12:LocaleCode>us</v12:LocaleCode>" +
//			"</v12:Localization>" +
//			"</v12:ClientDetail>" +
//			"<v12:TransactionDetail>" +
//			"<v12:CustomerTransactionId>Track By Number_v12</v12:CustomerTransactionId>" +
//			"</v12:TransactionDetail>" +
//			"<v12:Version>" +
//			"<v12:ServiceId>trck</v12:ServiceId>" +
//			"<v12:Major>12</v12:Major>" +
//			"<v12:Intermediate>0</v12:Intermediate>" +
//			"<v12:Minor>0</v12:Minor>" +
//			"</v12:Version>" +
//			"<v12:SelectionDetails>" +
//			"<v12:PackageIdentifier>" +
//			"<v12:Type>TRACKING_NUMBER_OR_DOORTAG</v12:Type>" +
//			"<v12:Value>715976975942</v12:Value>" +
//			"</v12:PackageIdentifier>" +
//			"</v12:SelectionDetails>" +
//			"</v12:TrackRequest>" +
//			"</soapenv:Body>" +
//		"</soapenv:Envelope>"
//		
//		callDataTask(body: soapMessage)
	}
	
	@IBAction func quickRate(_ sender: Any)
	{
		let web = RateRequest(
			webAuthenticationDetail: WebAuthenticationDetail(
				parentCredential: nil,
				userCredential: WebAuthenticationCredential(key: "ATjhnRZwKmclwko3", password: "yrsrYK0DeXj6RbbKrn51p8f8O")
			),
			clientDetail: ClientDetail(accountNumber: "510087100", meterNumber: "118784833", integratorId: nil, region: nil, localization: nil),
			transactionDetail: TransactionDetail(customerTransactionId: "FXR TEST", localization: nil),
			returnTransAndCommit: true,
			carrierCodes: nil,
			variableOptions: nil,
			consolidationKey: nil,
			requestedShipment: RequestedShipment(
				shipTimestamp: Date().addingTimeInterval(86400*2),
				dropoffType: DropoffType.REGULAR_PICKUP,
				serviceType: nil, //ServiceType.FEDEX_GROUND,
				packagingType: PackagingType.YOUR_PACKAGING,
				variationOptions: nil,
				totalWeight: Weight(units: WeightUnits.LB, value: 20.0),
				totalInsuredValue: nil,
				preferredCurrency: nil,
				shipmentAuthorizationDetail: nil,
				shipper: Party(
					accountNumber: nil,
					tins: nil,
					contact: nil,
					address: Address(
						streetLines: nil,
						city: "Plainfield",
						stateOrProvinceCode: "IN",
						postalCode: "46168",
						urbanizationCode: nil,
						countryCode: "US",
						countryName: nil,
						residential: false
					)
				),
				recipient: Party(
					accountNumber: nil,
					tins: nil,
					contact: nil,
					address: Address(
						streetLines: nil,
						city: "FRANKLIN",
						stateOrProvinceCode: "IN",
						postalCode: "46131",
						urbanizationCode: nil,
						countryCode: "US",
						countryName: nil,
						residential: false)
				),
				recipientLocationNumber: nil,
				origin: nil,
				soldTo: nil,
				shippingChargesPayment: nil,
				specialServicesRequested: nil,
				expressFreightDetail: nil,
				freightShipmentDetail: nil,
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
				packageCount: 1,
				shipmentOnlyFields: ShipmentOnlyFieldsType.WEIGHT,
				configurationData: nil,
				requestedPackageLineItems: RequestedPackageLineItem(
					sequenceNumber: 1,
					groupNumber: 1,
					groupPackageCount: 1,
					variableHandlingChargeDetail: nil,
					insuredValue: nil,
					weight: Weight(units: WeightUnits.LB, value: 20.0),
					dimensions: nil,
					physicalPackaging: PhysicalPackagingType.BOX,
					itemDescription: nil,
					itemDescriptionForClearance: nil,
					customerReferences: nil,
					specialServicesRequested: nil,
					contentRecords: nil
				)
			)
		)
		
		callDataTask(body: SoapMessage(message: web).description)
	}
	
	func getUrlRequest(body: String) -> URLRequest
	{
		var request = URLRequest(url: URL(string: "https://wsbeta.fedex.com:443/web-services/")!)
		
		request.httpMethod = "POST"
		request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
		request.httpBody = body.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
		
		return request
	}
	
	func callDataTask(body: String)
	{
		DispatchQueue.main.async(execute: { () -> Void in
			self.progressIndicator.startAnimation(self)
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
		
		if (showRawXml.state == NSOnState)
		{
			print(NSString(data: data2!, encoding: String.Encoding.utf8.rawValue) ?? "")
		}
		
		let httpResponse = response as? HTTPURLResponse
		
		DispatchQueue.main.async(execute: { () -> Void in
			self.httpResponseLabel.stringValue = "Status: \(httpResponse!.statusCode)"
		})
		
		if (httpResponse?.statusCode == 200)
		{
			// reset stack vars
			pathStack = Stack<String>()
			valueStack = Stack<ValuePath>()
			
			// init parser
			self.xmlParser = XMLParser(data: data2!)
			self.xmlParser.delegate = self
			self.xmlParser.parse()
		}
	}
}

extension AppDelegate: NSApplicationDelegate
{
	func applicationDidFinishLaunching(_ aNotification: Notification)
	{
		// Insert code here to initialize your application
		
		detailsTable.delegate = self
		detailsTable.dataSource = self
		detailsTable.reloadData()
		
		detailsView.delegate = self
		detailsView.dataSource = self
		detailsView.reloadData()
		
		progressIndicator.isDisplayedWhenStopped = false
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
		
		// set flag for grouping/identification
		if (elementName == "ServiceType") { service = "SET" }
		
		// store opening tag
		pathStack.push(elementName)
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String)
	{
		if (service == "SET") { service = string }
		
		// store full path and value
		valueStack.push((path: pathStack.xpath!, tag: service, value: string))
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
	{
		// remove value from stack to retain path integrity
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
		DispatchQueue.main.async(execute: { () -> Void in
			self.rateReply = RateReply(self.valueStack)
			
			if (self.showRawXml.state == NSOnState)
			{
				print("\(self.rateReply)")
			}
			
			// print non-SUCCESS messages
			if (self.rateReply.highestSeverity() != NotificationSeverityType.SUCCESS)
			{
				print(self.rateReply.notifications().filter{ $0.severity().value == self.rateReply.highestSeverity() } )
			}
		})
		
		DispatchQueue.main.async(execute: { () -> Void in
			self.progressIndicator.stopAnimation(self)
		})
		
		DispatchQueue.main.async(execute: { () -> Void in
			self.detailsTable.reloadData()
			self.detailsView.reloadData()
			self.httpResponseLabel.stringValue = "Status: Parsing Complete"
		})
	}
}

extension AppDelegate: NSTableViewDataSource
{
	func numberOfRows(in tableView: NSTableView) -> Int
	{
		if (valueStack.items.count == 0)
		{
			return 0
		}
		else if (self.rateReply.highestSeverity() == NotificationSeverityType.FAILURE)
		{
			return self.rateReply.notifications().count
		}
		else
		{
			return (rateReply.rateReplyDetails()?.count)! // valueStack.find("RateReply|RateReplyDetails|ServiceType|").count
		}
	}
}

extension AppDelegate: NSTableViewDelegate
{
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
	{
		// get record to display
		let svc = rateReply.rateReplyDetails()?[row].serviceType()?.rawValue
		
		if (tableColumn?.identifier == "NameCol") { return "Service" }
		else if (tableColumn?.identifier == "ValueCol") { return svc }
		
		return nil
	}
}

extension AppDelegate: NSOutlineViewDelegate
{
	func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any?
	{
		if let feed = item as? (Any, Any?)
		{
			if (tableColumn?.identifier == "NameColumn") {
				return feed.0
			} else {
				if let _ = feed.1 as? CommitDetail { return "" }
				
				return "\(feed.1 ?? "")"
			}
		}
		
		return nil
	}
}

extension AppDelegate: NSOutlineViewDataSource
{
	func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool
	{
		if let _ = item as? (Int, ServiceType) { return true }
		if let _ = item as? (String, CommitDetail) { return true }
		if let _ = item as? (String, fNotification) { return true }
		else { return false }
	}
	
	func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
	{
		if (valueStack.items.count == 0) { return 0 }
		if (rateReply.highestSeverity() == NotificationSeverityType.FAILURE) { return rateReply.notifications().count }
		
		if let _ = item as? (Int, ServiceType) { return 3 }
		if let _ = item as? (String, CommitDetail) { return 3 }
		else { return rateReply.rateReplyDetails()!.count }
	}
	
	func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any
	{
		if ((item as? (Int, Any?)) != nil) {	// child
			guard let i = item as? (Int, ServiceType) else { return "" }
			
			if (index == 0) { return (name: "Packaging Type", value: rateReply.rateReplyDetails()![i.0].packagingType()?.rawValue) }
			if (index == 1) { return (name: "Actual Rate Type", value: rateReply.rateReplyDetails()![i.0].actualRateType()?.rawValue) }
			else { return (name: "Commit Details", value: rateReply.rateReplyDetails()![i.0].commitDetails()?[i.0]) }
		}
		
		if let _item = item as? (String, CommitDetail) {	// child
			if (index == 0) { return (name: "Commit Timestamp", value: _item.1.commitTimestamp()) }
			if (index == 1) { return (name: "Day Of Week", value: _item.1.dayOfWeek()?.rawValue) }
			else { return (name: "Transit Time", value: _item.1.transitTime()?.rawValue) }
		}
		
		if ((item as? fNotification)) != nil {
			return rateReply.notifications()[index].message().value
		}
		
		if (rateReply.highestSeverity() == NotificationSeverityType.FAILURE) {
			return (name: rateReply.notifications().filter{ $0.severity().value == NotificationSeverityType.FAILURE }[0].message().name, value: rateReply.notifications().filter{ $0.severity().value == NotificationSeverityType.FAILURE }[0].message().value)
		}
		
		return (name: index, value: rateReply.rateReplyDetails()![index].serviceType())
	}
}
