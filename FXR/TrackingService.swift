////
////  TrackingService.swift
////  FXR
////
////  Created by Tobey Unruh on 4/21/17.
////  Copyright © 2017 Tobey Unruh. All rights reserved.
////
//
//import Foundation
//
//private struct SoapMessage : CustomStringConvertible
//{
//	fileprivate let _message: String
//	
//	var description: String { return "<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" " +
//		"xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" " +
//		"xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" " +
//		"xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" " +
//		"xmlns:v12=\"http://fedex.com/ws/track/v12\"><SOAP-ENV:Body>\(_message)</SOAP-ENV:Body></SOAP-ENV:Envelope>" }
//	
//	init(message: String)
//	{
//		_message = message
//	}
//}
//
//struct TrackRequest : CustomStringConvertible
//{
//	fileprivate let _webAuthenticationDetail: WebAuthenticationDetail
//	fileprivate let _clientDetail: ClientDetail
//	fileprivate let _transactionDetail: TransactionDetail?
//	fileprivate let _version: VersionId
//	fileprivate let _selectionDetails: [TrackSelectionDetail]?
//	fileprivate let _transactionTimeOutValueInMilliseconds: UInt?
//	fileprivate let _processingOptions: [TrackRequestProcessingOptionType]?
//	
//	var description: String { return SoapMessage("<\(type(of: self))>\(webAuthenticationDetail())\(clientDetail())\(transactionDetail())\(version())\(returnTransitAndCommit())\(carrierCodes())\(variableOptions())\(consolidationKey())\(requestedShipment())</\(type(of: self))>") }
//	
//	init(webAuthenticationDetail: WebAuthenticationDetail, clientDetail: ClientDetail, transactionDetail: TransactionDetail?, returnTransAndCommit: Bool?, carrierCodes: CarrierCodeType?, variableOptions: ServiceOptionType?, consolidationKey: ConsolidationKey?, requestedShipment: RequestedShipment?)
//	{
//		_webAuthenticationDetail = webAuthenticationDetail
//		_clientDetail = clientDetail
//		_transactionDetail = transactionDetail
//		_version = VersionId()
//		_selectionDetails = selectionDetails
//		_transactionTimeOutValueInMilliseconds = transactionTimeOutValueInMilliseconds
//		_processingOptions = processingOptions
//	}
//	
//	func webAuthenticationDetail() -> String { return "<WebAuthenticationDetail>\(_webAuthenticationDetail)</WebAuthenticationDetail>" }
//	func clientDetail() -> String { return "<ClientDetail>\(_clientDetail)</ClientDetail>" }
//	func transactionDetail() -> String { return (_transactionDetail == nil ? "" : "<TransactionDetail>\(_transactionDetail!)</TransactionDetail>") }
//	func version() -> String { return "<Version>\(_version)</Version>" }
//}
//
//private struct VersionId : CustomStringConvertible
//{
//	fileprivate let _serviceId: String = "trck"
//	fileprivate let _major: Int = 12
//	fileprivate let _intermediate: Int = 0
//	fileprivate let _minor: Int = 0
//	
//	var description: String { return "\(serviceId())\(major())\(intermediate())\(minor())" }
//	
//	func serviceId() -> String { return "<ServiceId>\(_serviceId)</ServiceId>" }
//	func major() -> String { return "<Major>\(_major)</Major>" }
//	func intermediate() -> String { return "<Intermediate>\(_intermediate)</Intermediate>" }
//	func minor() -> String { return "<Minor>\(_minor)</Minor>" }
//}
//
//struct SelectionDetails : CustomStringConvertible
//{
//	<xs:element name="CarrierCode" type="ns:CarrierCodeType" minOccurs="0">
//	<xs:element name="OperatingCompany" type="ns:OperatingCompanyType" minOccurs="0">
//	<xs:element name="PackageIdentifier" type="ns:TrackPackageIdentifier" minOccurs="0">
//	<xs:element name="TrackingNumberUniqueIdentifier" type="xs:string" minOccurs="0">
//	<xs:element name="ShipDateRangeBegin" type="xs:date" minOccurs="0">
//	<xs:element name="ShipDateRangeEnd" type="xs:date" minOccurs="0">
//	<xs:element name="ShipmentAccountNumber" type="xs:string" minOccurs="0">
//	<xs:element name="SecureSpodAccount" type="xs:string" minOccurs="0">
//	<xs:element name="Destination" type="ns:Address" minOccurs="0">
//	<xs:element name="PagingDetail" type="ns:PagingDetail" minOccurs="0">
//	<xs:element name="CustomerSpecifiedTimeOutValueInMilliseconds" type="xs:nonNegativeInteger" minOccurs="0">
//}
