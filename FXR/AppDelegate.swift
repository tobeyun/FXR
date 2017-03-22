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

@NSApplicationMain
class AppDelegate: NSObject
{
	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var senderZipCodeTextField: NSTextField!
	@IBOutlet weak var recipientZipCodeTextField: NSTextField!
	@IBOutlet weak var weightTextField: NSTextField!
	@IBOutlet weak var trackingNumberTextField: NSTextField!
	@IBOutlet weak var rateButton: NSButton!
	@IBOutlet weak var trackButton: NSButton!
	@IBOutlet weak var rateResultsTextField: NSTextField!
	@IBOutlet weak var detailsTable: NSTableView!
	@IBOutlet weak var progressIndicator: NSProgressIndicator!

	@IBAction func quickRate(_ sender: Any)
	{
		//print ("rate")
		
		let soapMessage = "<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://fedex.com/ws/rate/v20\">" +
			"<SOAP-ENV:Body>" +
			"<RateRequest>" +
			"<WebAuthenticationDetail>" +
			"<UserCredential>" +
			"<Key>ATjhnRZwKmclwko3</Key>" +
			"<Password>yrsrYK0DeXj6RbbKrn51p8f8O</Password>" +
			"</UserCredential>" +
			"</WebAuthenticationDetail>" +
			"<ClientDetail>" +
			"<AccountNumber>510087100</AccountNumber>" +
			"<MeterNumber>118784833</MeterNumber>" +
			"</ClientDetail>" +
			"<TransactionDetail>" +
			"<CustomerTransactionId>TC023_US_PRIORITY_OVERNIGHT with Your Packaging</CustomerTransactionId>" +
			"</TransactionDetail>" +
			"<Version>" +
			"<ServiceId>crs</ServiceId>" +
			"<Major>20</Major>" +
			"<Intermediate>0</Intermediate>" +
			"<Minor>0</Minor>" +
			"</Version>" +
			"<RequestedShipment>" +
			"<DropoffType>REGULAR_PICKUP</DropoffType>" +
			"<ServiceType>PRIORITY_OVERNIGHT</ServiceType>" +
			"<PackagingType>YOUR_PACKAGING</PackagingType>" +
			"<TotalWeight>" +
			"<Units>LB</Units>" +
			"<Value>1.0</Value>" +
			"</TotalWeight>" +
			"<Shipper>" +
			"<Address>" +
			"<StateOrProvinceCode>IN</StateOrProvinceCode>" +
			"<PostalCode>46131</PostalCode>" +
			"<CountryCode>US</CountryCode>" +
			"</Address>" +
			"</Shipper>" +
			"<Recipient>" +
			"<Address>" +
			"<StateOrProvinceCode>TN</StateOrProvinceCode>" +
			"<PostalCode>38017</PostalCode>" +
			"<CountryCode>US</CountryCode>" +
			"</Address>" +
			"</Recipient>" +
			"<ShippingChargesPayment>" +
			"<PaymentType>SENDER</PaymentType>" +
			"</ShippingChargesPayment>" +
			"<RateRequestTypes>LIST</RateRequestTypes>" +
			"<PackageCount>2</PackageCount>" +
			"<RequestedPackageLineItems>" +
			"<SequenceNumber>1</SequenceNumber>" +
			"<GroupNumber>1</GroupNumber>" +
			"<GroupPackageCount>1</GroupPackageCount>" +
			"<Weight>" +
			"<Units>LB</Units>" +
			"<Value>1.0</Value>" +
			"</Weight>" +
			"</RequestedPackageLineItems>" +
			"<RequestedPackageLineItems>" +
			"<SequenceNumber>2</SequenceNumber>" +
			"<GroupNumber>1</GroupNumber>" +
			"<GroupPackageCount>1</GroupPackageCount>" +
			"<Weight>" +
			"<Units>LB</Units>" +
			"<Value>4.0</Value>" +
			"</Weight>" +
			"</RequestedPackageLineItems>" +
			"</RequestedShipment>" +
			"</RateRequest>" +
			"</SOAP-ENV:Body>" +
		"</SOAP-ENV:Envelope>"
		
		callDataTask(body: soapMessage)
	}
	
	//var rateRequest: RateRequest
	var xmlParser = XMLParser()
	var pathStack = Stack<String>()
	var valueStack = Stack<String>()
	
	@IBAction func quickTrack(_ sender: NSButton)
	{
		let soapMessage = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v12=\"http://fedex.com/ws/track/v12\"><soapenv:Header> </soapenv:Header>" +
			"<soapenv:Body>" +
			"<v12:TrackRequest>" +
			"<v12:WebAuthenticationDetail>" +
			"<v12:UserCredential>" +
			"<v12:Key>ATjhnRZwKmclwko3</v12:Key>" +
			"<v12:Password>yrsrYK0DeXj6RbbKrn51p8f8O</v12:Password>" +
			"</v12:UserCredential>" +
			"</v12:WebAuthenticationDetail>" +
			"<v12:ClientDetail>" +
			"<v12:AccountNumber>510087100</v12:AccountNumber>" +
			"<v12:MeterNumber>118784833</v12:MeterNumber>" +
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
			"<v12:Value>715976975942</v12:Value>" +
			"</v12:PackageIdentifier>" +
			"</v12:SelectionDetails>" +
			"</v12:TrackRequest>" +
			"</soapenv:Body>" +
		"</soapenv:Envelope>"
		
		callDataTask(body: soapMessage)
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
		
		window.update()
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
			print(NSString(data: data2!, encoding: String.Encoding.utf8.rawValue) ?? "")
//		}
		
		let httpResponse = response as? HTTPURLResponse
		
		//print(httpResponse!.statusCode)
		
		if (httpResponse?.statusCode != 200)
		{
			//self.rateResultsTextField.stringValue = String(describing: httpResponse?.statusCode) + "\n"
		}
		else
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
		valueStack.push(pathStack.xpath! + ":" + string)
		
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
	}
}

extension AppDelegate: NSTableViewDataSource
{
	func numberOfRows(in tableView: NSTableView) -> Int
	{
		return valueStack.find("ServiceType").count
	}
}

extension AppDelegate: NSTableViewDelegate
{
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
	{
		// get record to display
		let nameItem = valueStack.find("ServiceType").map{ $0.components(separatedBy: ":").last! }[row]
		let valueItem = valueStack.find("TotalNetChargeWithDutiesAndTaxes:Amount").map{ $0.components(separatedBy: ":").last! }[row]
		
		if (tableColumn?.identifier == "NameCol")
		{
			return nameItem
		}
		else if (tableColumn?.identifier == "ValueCol")
		{
			return valueItem
		}
		
		return nil
	}
}

