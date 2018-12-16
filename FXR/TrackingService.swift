//
//  TrackingService.swift
//  FXR
//
//  Created by Tobey Unruh on 4/21/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Foundation

private struct SoapMessage : CustomStringConvertible
{
	fileprivate let _message: String
	
	var description: String { return "<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" " +
                                        "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" " +
                                        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" " +
                                        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" " +
                                        "xmlns=\"http://fedex.com/ws/track/v12\"><SOAP-ENV:Body>\(_message)</SOAP-ENV:Body></SOAP-ENV:Envelope>" }
	
	init(_ message: String)
	{
		_message = message
	}
}

struct TrackRequest : CustomStringConvertible
{
	fileprivate let _webAuthenticationDetail: WebAuthenticationDetail
	fileprivate let _clientDetail: ClientDetail
	fileprivate let _transactionDetail: TransactionDetail?
	fileprivate let _version: VersionId
	fileprivate let _selectionDetails: [TrackSelectionDetail]?
	fileprivate let _transactionTimeOutValueInMilliseconds: Int?
	fileprivate let _processingOptions: [TrackRequestProcessingOptionType]?
	
	var description: String { return "\(SoapMessage("<\(type(of: self))>\(webAuthenticationDetail())\(clientDetail())\(transactionDetail())\(version())\(selectionDetails())\(transactionTimeOutValueInMilliseconds())\(processingOptions())</\(type(of: self))>"))" }
	
	init(webAuthenticationDetail: WebAuthenticationDetail,
	     clientDetail: ClientDetail,
	     transactionDetail: TransactionDetail?,
	     selectionDetails: [TrackSelectionDetail]?,
	     transactionTimeOutValueInMilliseconds: Int?,
	     processingOptions: [TrackRequestProcessingOptionType]?)
	{
		_webAuthenticationDetail = webAuthenticationDetail
		_clientDetail = clientDetail
		_transactionDetail = transactionDetail
		_version = VersionId()
		_selectionDetails = selectionDetails
		_transactionTimeOutValueInMilliseconds = transactionTimeOutValueInMilliseconds
		_processingOptions = processingOptions
	}
	
	func webAuthenticationDetail() -> String { return "<WebAuthenticationDetail>\(_webAuthenticationDetail)</WebAuthenticationDetail>" }
	func clientDetail() -> String { return "<ClientDetail>\(_clientDetail)</ClientDetail>" }
	func transactionDetail() -> String { return (_transactionDetail == nil ? "" : "<TransactionDetail>\(_transactionDetail!)</TransactionDetail>") }
	func version() -> String { return "<Version>\(_version)</Version>" }
	func selectionDetails() -> String { return (_selectionDetails == nil ? "" : "\((_selectionDetails?.map{ "<SelectionDetails>\($0)</SelectionDetails>" } as [String]?)!.joined())") }
	func transactionTimeOutValueInMilliseconds() -> String { return (_transactionTimeOutValueInMilliseconds == nil ? "" : "<TransactionTimeOutValueInMilliseconds>\(_transactionTimeOutValueInMilliseconds!)</TransactionTimeOutValueInMilliseconds>") }
	func processingOptions() -> String { return (_processingOptions == nil ? "" : "\((_processingOptions?.map{ "<ProcessingOptions>\($0)</ProcessingOptions>" } as [String]?)!.joined())") }
}

private struct VersionId : CustomStringConvertible
{
	fileprivate let _serviceId: String = "trck"
	fileprivate let _major: Int = 12
	fileprivate let _intermediate: Int = 0
	fileprivate let _minor: Int = 0
	
	var description: String { return "\(serviceId())\(major())\(intermediate())\(minor())" }
	
	func serviceId() -> String { return "<ServiceId>\(_serviceId)</ServiceId>" }
	func major() -> String { return "<Major>\(_major)</Major>" }
	func intermediate() -> String { return "<Intermediate>\(_intermediate)</Intermediate>" }
	func minor() -> String { return "<Minor>\(_minor)</Minor>" }
}

struct TrackSelectionDetail : CustomStringConvertible
{
	fileprivate let _carrierCode: CarrierCodeType?
	fileprivate let _operatingCompany: OperatingCompanyType?
	fileprivate let _packageIdentifier: TrackPackageIdentifier?
	fileprivate let _trackingNumberUniqueIdentifier: String?
	fileprivate let _shipDateRangeBegin: Date?
	fileprivate let _shipDateRangeEnd: Date?
	fileprivate let _shipmentAccountNumber: String?
	fileprivate let _secureSpodAccount: String?
	fileprivate let _destination: Address?
	fileprivate let _pagingDetail: PagingDetail?
	fileprivate let _customerSpecifiedTimeOutValueInMilliseconds: Int?
	
	var description: String { return "\(carrierCode())\(operatingCompany())\(packageIdentifier())\(trackingNumberUniqueIdentifier())\(shipDateRangeBegin())\(shipDateRangeEnd())\(shipmentAccountNumber())\(secureSpodAccount())\(destination())\(pagingDetail())\(customerSpecifiedTimeOutValueinMilliseconds())" }
	
	init(carrierCode: CarrierCodeType?,
	     operatingCompany: OperatingCompanyType?,
	     packageIdentifier: TrackPackageIdentifier?,
	     trackingNumberUniqueIdentifier: String?,
	     shipDateRangeBegin: Date?,
	     shipDateRangeEnd: Date?,
	     shipmentAccountNumber: String?,
	     secureSpodAccount: String?,
	     destination: Address?,
	     pagingDetail: PagingDetail?,
	     customerSpecifiedTimeOutValueInMilliseconds: Int?)
	{
		_carrierCode = carrierCode
		_operatingCompany = operatingCompany
		_packageIdentifier = packageIdentifier
		_trackingNumberUniqueIdentifier = trackingNumberUniqueIdentifier
		_shipDateRangeBegin = shipDateRangeBegin
		_shipDateRangeEnd = shipDateRangeEnd
		_shipmentAccountNumber = shipmentAccountNumber
		_secureSpodAccount = secureSpodAccount
		_destination = destination
		_pagingDetail = pagingDetail
		_customerSpecifiedTimeOutValueInMilliseconds = customerSpecifiedTimeOutValueInMilliseconds
	}
	
	func carrierCode() -> String { return (_carrierCode == nil ? "" : "<CarrierCode>\(_carrierCode!)</CarrierCode>") }
	func operatingCompany() -> String { return (_operatingCompany == nil ? "" : "<OperatingCompany>\(_operatingCompany!)</OperatingCompany>") }
	func packageIdentifier() -> String { return (_packageIdentifier == nil ? "" : "<PackageIdentifier>\(_packageIdentifier!)</PackageIdentifier>") }
	func trackingNumberUniqueIdentifier() -> String { return (_trackingNumberUniqueIdentifier == nil ? "" : "<TrackingNumberUniqueIdentifier>\(_trackingNumberUniqueIdentifier!)</TrackingNumberUniqueIdentifier>") }
	func shipDateRangeBegin() -> String { return (_shipDateRangeBegin == nil ? "" : "<ShipDateRangeBegin>\(_shipDateRangeBegin!)</ShipDateRangeBegin>") }
	func shipDateRangeEnd() -> String { return (_shipDateRangeEnd == nil ? "" : "<ShipDateRangeEnd>\(_shipDateRangeEnd!)</ShipDateRangeEnd>") }
	func shipmentAccountNumber() -> String { return (_shipmentAccountNumber == nil ? "" : "<ShipmentAccountNumber>\(_shipmentAccountNumber!)</ShipmentAccountNumber>") }
	func secureSpodAccount() -> String { return (_secureSpodAccount == nil ? "" : "<SecureSpodAccount>\(_secureSpodAccount!)</SecureSpodAccount>") }
	func destination() -> String { return (_destination == nil ? "" : "<Destination>\(_destination!)</Destination>") }
	func pagingDetail() -> String { return (_pagingDetail == nil ? "" : "<PagingDetail>\(_pagingDetail!)</PagingDetail>") }
	func customerSpecifiedTimeOutValueinMilliseconds() -> String { return (_customerSpecifiedTimeOutValueInMilliseconds == nil ? "" : "<CustomerSpecifiedTimeOutValueInMilliseconds>\(_customerSpecifiedTimeOutValueInMilliseconds!)</CustomerSpecifiedTimeOutValueInMilliseconds>") }
}

struct TrackPackageIdentifier : CustomStringConvertible
{
	let _type: TrackIdentifierType
	let _value: String
	
	var description: String { return "\(type())\(value())" }
	
	init(type: TrackIdentifierType, value: String)
	{
		_type = type
		_value = value
	}
	
	func type() -> String { return "<Type>\(_type)</Type>" }
	func value() -> String { return "<Value>\(_value)</Value>" }
}

struct PagingDetail : CustomStringConvertible
{
	let _pagingToken: String?
	let _numberOfResultsPerPage: Int?
	
	var description: String { return "\(pagingToken())\(numberOfResultsPerPage())" }
	
	func pagingToken() -> String { return "<PagingToken>\(_pagingToken!)</PagingToken>" }
	func numberOfResultsPerPage() -> String { return "<NumberOfResultsPerPage>\(_numberOfResultsPerPage!)</NumberOfResultsPerPage>" }
}

