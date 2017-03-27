//
//  AppDelegate.swift
//  iFXCT
//
//  Created by Tobey Unruh on 1/19/16.
//  Copyright © 2016 Tobey Unruh. All rights reserved.
//

import Cocoa

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
		return items.isEmpty ? nil : items.map{ String(describing: $0) }.joined(separator: ":") as? Element
	}
	
	func find(_ search: String) -> [Element] {
		return items.filter{ String(describing: $0).contains(search) }
	}
}

extension Collection where Indices.Iterator.Element == Index {
	
	/// Returns the element at the specified index iff it is within bounds, otherwise nil.
	subscript (safe index: Index) -> Generator.Element? {
		return indices.contains(index) ? self[index] : nil
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
	
	//var rateRequest: RateRequest
	var xmlParser = XMLParser()
	var pathStack = Stack<String>()
	var valueStack = Stack<String>()

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
				shipTimestamp: NSDate(),
				dropoffType: DropoffType.REGULAR_PICKUP,
				serviceType: nil,
				packagingType: PackagingType.YOUR_PACKAGING,
				variationOptions: nil,
				totalWeight: Weight(units: WeightUnits.LB, value: 1.0),
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
					weight: nil,
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

		let soapMessage = SoapMessage(message: web)

		callDataTask(body: soapMessage.description)
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
		progressIndicator.startAnimation(self)
		
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
		
//		if (showRawData.state == NSOnState)
//		{
		//print(NSString(data: data2!, encoding: String.Encoding.utf8.rawValue) ?? "")
//		}
		
		let httpResponse = response as? HTTPURLResponse
		
		DispatchQueue.main.async(execute: { () -> Void in
			self.httpResponseLabel.stringValue = "Status: \(httpResponse!.statusCode)"
		})
		
		if (httpResponse?.statusCode == 200)
		{
			pathStack = Stack<String>()
			valueStack = Stack<String>()
			
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
		pathStack.push(elementName)
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String)
	{
		// add value to path
		pathStack.push(string)
		
		// store full path
		valueStack.push(pathStack.xpath!)
		
		// remove value from stack to retain path integrity; ignore return
		let _  = pathStack.pop()
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
	{
		// remove closing tag from stack to retain path integrity
		if (pathStack.peek == elementName)
		{
			// ignore return
			let _ = pathStack.pop()
		}
	}
	
	func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
	{
		
	}
	
	func parserDidEndDocument(_ parser: XMLParser)
	{
		progressIndicator.stopAnimation(self)
		
		detailsTable.reloadData()
		
		DispatchQueue.main.async(execute: { () -> Void in
			self.detailsTable.reloadData()
		})
		
		//print(RateReply(stack: valueStack).rateReplyDetails().serviceType())
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
		else
		{
			return RateReply(stack: valueStack).rateReplyDetails().serviceType().count
		}
	}
}

extension AppDelegate: NSTableViewDelegate
{
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
	{
		// get record to display
		let nameItem = RateReply(stack: valueStack).rateReplyDetails().serviceType()[row].rawValue
		//let valueItem = valueStack.find("TotalNetChargeWithDutiesAndTaxes:Amount").map{ $0.components(separatedBy: ":").last! }[row]
		
		if (tableColumn?.identifier == "NameCol")
		{
			return nameItem
		}
		else if (tableColumn?.identifier == "ValueCol")
		{
			//return valueItem
		}
		
		return nil
	}
}
