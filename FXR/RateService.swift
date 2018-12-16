//
//  RateService.swift
//  FXR
//
//  Created by Tobey Unruh on 3/23/17.
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
										"xmlns=\"http://fedex.com/ws/rate/v20\"><SOAP-ENV:Body>\(_message)</SOAP-ENV:Body></SOAP-ENV:Envelope>" }
	
	init(_ message: String)
	{
		_message = message
	}
}

final class RateRequest : CustomStringConvertible
{
	fileprivate let _webAuthenticationDetail: WebAuthenticationDetail
	fileprivate let _clientDetail: ClientDetail
	fileprivate let _transactionDetail: TransactionDetail?
	fileprivate let _version: VersionId
	fileprivate let _returnTransitAndCommit: Bool?
	fileprivate let _carrierCodes: CarrierCodeType?
	fileprivate let _variableOptions: ServiceOptionType?
	fileprivate let _consolidationKey: ConsolidationKey?
	fileprivate let _requestedShipment: RequestedShipment?

	var description: String { return "\(SoapMessage("<\(type(of: self))>\(webAuthenticationDetail())\(clientDetail())\(transactionDetail())\(version())\(returnTransitAndCommit())\(carrierCodes())\(variableOptions())\(consolidationKey())\(requestedShipment())</\(type(of: self))>"))" }
	
	init(webAuthenticationDetail: WebAuthenticationDetail, clientDetail: ClientDetail, transactionDetail: TransactionDetail?, returnTransAndCommit: Bool?, carrierCodes: CarrierCodeType?, variableOptions: ServiceOptionType?, consolidationKey: ConsolidationKey?, requestedShipment: RequestedShipment?)
	{
		_webAuthenticationDetail = webAuthenticationDetail
		_clientDetail = clientDetail
		_transactionDetail = transactionDetail
		_version = VersionId()
		_returnTransitAndCommit = returnTransAndCommit ?? false
		_carrierCodes = carrierCodes
		_variableOptions = variableOptions
		_consolidationKey = consolidationKey
		_requestedShipment = requestedShipment
	}
	
	func webAuthenticationDetail() -> String { return "<WebAuthenticationDetail>\(_webAuthenticationDetail)</WebAuthenticationDetail>" }
	func clientDetail() -> String { return "<ClientDetail>\(_clientDetail)</ClientDetail>" }
	func transactionDetail() -> String { return (_transactionDetail == nil ? "" : "<TransactionDetail>\(_transactionDetail!)</TransactionDetail>") }
	func version() -> String { return "<Version>\(_version)</Version>" }
	func returnTransitAndCommit() -> String { return "<ReturnTransitAndCommit>\(_returnTransitAndCommit!)</ReturnTransitAndCommit>" }
	func carrierCodes() -> String { return (_carrierCodes == nil ? "" : "<CarrierCodes>\(_carrierCodes!)</CarrierCodes>") }
	func variableOptions() -> String { return (_variableOptions == nil ? "" : "<VariableOptions>\(_variableOptions!)</VariableOptions>") }
	func consolidationKey() -> String { return (_consolidationKey == nil ? "" : "<ConsolidationKey>\(_consolidationKey!)</ConsolidationKey>") }
	func requestedShipment() -> String { return (_requestedShipment == nil ? "" : "<RequestedShipment>\(_requestedShipment!)</RequestedShipment>") }
}

private struct VersionId : CustomStringConvertible
{
	fileprivate let _serviceId: String = "crs"
	fileprivate let _major: Int = 20
	fileprivate let _intermediate: Int = 0
	fileprivate let _minor: Int = 0

	var description: String { return "\(serviceId())\(major())\(intermediate())\(minor())" }
	
	func serviceId() -> String { return "<ServiceId>\(_serviceId)</ServiceId>" }
	func major() -> String { return "<Major>\(_major)</Major>" }
	func intermediate() -> String { return "<Intermediate>\(_intermediate)</Intermediate>" }
	func minor() -> String { return "<Minor>\(_minor)</Minor>" }
}

final class ConsolidationKey : CustomStringConvertible
{
	fileprivate let _type: ConsolidationType?
	fileprivate let _index: String?
	fileprivate let _date: Date?

	var description: String { return "<\(Swift.type(of: self))>\(type())\(index())\(date())</\(Swift.type(of: self))>" }
	
	init(type: ConsolidationType?, index: String?, date: Date?)
	{
		_type = type
		_index = index
		_date = date
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func index() -> String { return (_index == nil ? "" : "<Index>\(_index!)</Index>") }
	func date() -> String { return (_date == nil ? "" : "<Date>\(formatDate(_date!))</Date>") }
}

final class RequestedShipment : CustomStringConvertible
{
	fileprivate let _shipTimestamp: Date?
	fileprivate let _dropoffType: DropoffType?
	fileprivate let _serviceType: ServiceType?
	fileprivate let _packagingType: PackagingType?
	fileprivate let _variationOptions: ShipmentVariationOptionDetail?
	fileprivate let _totalWeight: Weight?
	fileprivate let _totalInsuredValue: Money?
	fileprivate let _preferredCurrency: String?
	fileprivate let _shipmentAuthorizationDetail: ShipmentAuthorizationDetail?
	fileprivate let _shipper: Party?
	fileprivate let _recipient: Party?
	fileprivate let _recipientLocationNumber: String?
	fileprivate let _origin: ContactAndAddress?
	fileprivate let _soldTo: Party?
	fileprivate let _shippingChargesPayment: Payment?
	fileprivate let _specialServicesRequested: ShipmentSpecialServicesRequested?
	fileprivate let _expressFreightDetail: ExpressFreightDetail?
	fileprivate let _freightShipmentDetail: FreightShipmentDetail?
	fileprivate let _deliveryInstructions: String?
	fileprivate let _variableHandlingChargeDetail: VariableHandlingChargeDetail?
	fileprivate let _customsClearanceDetail: CustomsClearanceDetail?
	fileprivate let _pickupDetail: PickupDetail?
	fileprivate let _smartPostDetail: SmartPostShipmentDetail?
	fileprivate let _blockInsightVisibility: Bool?
	fileprivate let _labelSpecification: LabelSpecification?
	fileprivate let _shippingDocumentSpecification: ShippingDocumentSpecification?
	fileprivate let _rateRequestTypes: RateRequestType?
	fileprivate let _edtRequestType: EdtRequestType?
	fileprivate let _packageCount: Int?
	fileprivate let _shipmentOnlyFields: ShipmentOnlyFieldsType?
	fileprivate let _configurationData: ShipmentConfigurationData?
	fileprivate let _requestedPackageLineItems: [RequestedPackageLineItem]?

	var description: String { return "\(shipTimestamp())\(dropoffType())\(serviceType())\(packagingType())\(variationOptions())\(totalWeight())\(totalInsuredValue())\(preferredCurrency())\(shipmentAuthorizationDetail())\(shipper())\(recipient())\(recipientLocationNumber())\(origin())\(soldTo())\(shippingChargesPayment())\(specialServicesRequested())\(expressFreightDetail())\(freightShipmentDetail())\(deliveryInstructions())\(variableHandlingChargeDetail())\(customsClearanceDetail())\(pickupDetail())\(smartPostDetail())\(blockInsightVisibility())\(labelSpecification())\(shippingDocumentSpecification())\(rateRequestTypes())\(edtRequestType())\(packageCount())\(shipmentOnlyFields())\(configurationData())\(requestedPackageLineItems())" }
	
	init(shipTimestamp: Date?, dropoffType: DropoffType?, serviceType: ServiceType?, packagingType: PackagingType?, variationOptions: ShipmentVariationOptionDetail?, totalWeight: Weight?, totalInsuredValue: Money?, preferredCurrency: String?, shipmentAuthorizationDetail: ShipmentAuthorizationDetail?, shipper: Party?, recipient: Party?, recipientLocationNumber: String?, origin: ContactAndAddress?, soldTo: Party?, shippingChargesPayment: Payment?, specialServicesRequested: ShipmentSpecialServicesRequested?, expressFreightDetail: ExpressFreightDetail?, freightShipmentDetail: FreightShipmentDetail?, deliveryInstructions: String?, variableHandlingChargeDetail: VariableHandlingChargeDetail?, customsClearanceDetail: CustomsClearanceDetail?, pickupDetail: PickupDetail?, smartPostDetail: SmartPostShipmentDetail?, blockInsightVisibility: Bool?, labelSpecification: LabelSpecification?, shippingDocumentSpecification: ShippingDocumentSpecification?, rateRequestTypes: RateRequestType?, edtRequestType: EdtRequestType?, packageCount: Int?, shipmentOnlyFields: ShipmentOnlyFieldsType?, configurationData: ShipmentConfigurationData?, requestedPackageLineItems: [RequestedPackageLineItem]?)
	{
		_shipTimestamp = shipTimestamp
		_dropoffType = dropoffType
		_serviceType = serviceType
		_packagingType = packagingType
		_variationOptions = variationOptions
		_totalWeight = totalWeight
		_totalInsuredValue = totalInsuredValue
		_preferredCurrency = preferredCurrency
		_shipmentAuthorizationDetail = shipmentAuthorizationDetail
		_shipper = shipper
		_recipient = recipient
		_recipientLocationNumber = recipientLocationNumber
		_origin = origin
		_soldTo = soldTo
		_shippingChargesPayment = shippingChargesPayment
		_specialServicesRequested = specialServicesRequested
		_expressFreightDetail = expressFreightDetail
		_freightShipmentDetail = freightShipmentDetail
		_deliveryInstructions = deliveryInstructions
		_variableHandlingChargeDetail = variableHandlingChargeDetail
		_customsClearanceDetail = customsClearanceDetail
		_pickupDetail = pickupDetail
		_smartPostDetail = smartPostDetail
		_blockInsightVisibility = blockInsightVisibility
		_labelSpecification = labelSpecification
		_shippingDocumentSpecification = shippingDocumentSpecification
		_rateRequestTypes = rateRequestTypes
		_edtRequestType = edtRequestType
		_packageCount = packageCount
		_shipmentOnlyFields = shipmentOnlyFields
		_configurationData = configurationData
		_requestedPackageLineItems = requestedPackageLineItems
	}
	
	func shipTimestamp() -> String { return (_shipTimestamp == nil ? "" : "<ShipTimestamp>\(formatDate(_shipTimestamp!))</ShipTimestamp>") }
	func dropoffType() -> String { return (_dropoffType == nil ? "" : "<DropoffType>\(_dropoffType!)</DropoffType>") }
	func serviceType() -> String { return (_serviceType == nil ? "" : "<ServiceType>\(_serviceType!)</ServiceType>") }
	func packagingType() -> String { return (_packagingType == nil ? "" : "<PackagingType>\(_packagingType!)</PackagingType>") }
	func variationOptions() -> String { return (_variationOptions == nil ? "" : "<VariationOptions>\(_variationOptions!)</VariationOptions>") }
	func totalWeight() -> String { return (_totalWeight == nil ? "" : "<TotalWeight>\(_totalWeight!)</TotalWeight>") }
	func totalInsuredValue() -> String { return (_totalInsuredValue == nil ? "" : "<TotalInsuredValue>\(_totalInsuredValue!)</TotalInsuredValue>") }
	func preferredCurrency() -> String { return (_preferredCurrency == nil ? "" : "<PreferredCurrency>\(_preferredCurrency!)</PreferredCurrency>") }
	func shipmentAuthorizationDetail() -> String { return (_shipmentAuthorizationDetail == nil ? "" : "<ShipmentAuthorizationDetail>\(_shipmentAuthorizationDetail!)</ShipmentAuthorizationDetail>") }
	func shipper() -> String { return (_shipper == nil ? "" : "<Shipper>\(_shipper!)</Shipper>") }
	func recipient() -> String { return (_recipient == nil ? "" : "<Recipient>\(_recipient!)</Recipient>") }
	func recipientLocationNumber() -> String { return (_recipientLocationNumber == nil ? "" : "<RecipientLocationNumber>\(_recipientLocationNumber!)</RecipientLocationNumber>") }
	func origin() -> String { return (_origin == nil ? "" : "<Origin>\(_origin!)</Origin>") }
	func soldTo() -> String { return (_soldTo == nil ? "" : "<SoldTo>\(_soldTo!)</SoldTo>") }
	func shippingChargesPayment() -> String { return (_shippingChargesPayment == nil ? "" : "<ShippingChargesPayment>\(_shippingChargesPayment!)</ShippingChargesPayment>") }
	func specialServicesRequested() -> String { return (_specialServicesRequested == nil ? "" : "<SpecialServicesRequested>\(_specialServicesRequested!)</SpecialServicesRequested>") }
	func expressFreightDetail() -> String { return (_expressFreightDetail == nil ? "" : "<ExpressFreightDetail>\(_expressFreightDetail!)</ExpressFreightDetail>") }
	func freightShipmentDetail() -> String { return (_freightShipmentDetail == nil ? "" : "<FreightShipmentDetail>\(_freightShipmentDetail!)</FreightShipmentDetail>") }
	func deliveryInstructions() -> String { return (_deliveryInstructions == nil ? "" : "<DeliveryInstructions>\(_deliveryInstructions!)</DeliveryInstructions>") }
	func variableHandlingChargeDetail() -> String { return (_variableHandlingChargeDetail == nil ? "" : "<VariableHandlingChargeDetail>\(_variableHandlingChargeDetail!)</VariableHandlingChargeDetail>") }
	func customsClearanceDetail() -> String { return (_customsClearanceDetail == nil ? "" : "<CustomsClearanceDetail>\(_customsClearanceDetail!)</CustomsClearanceDetail>") }
	func pickupDetail() -> String { return (_pickupDetail == nil ? "" : "<PickupDetail>\(_pickupDetail!)</PickupDetail>") }
	func smartPostDetail() -> String { return (_smartPostDetail == nil ? "" : "<SmartPostDetail>\(_smartPostDetail!)</SmartPostDetail>") }
	func blockInsightVisibility() -> String { return (_blockInsightVisibility == nil ? "" : "<BlockInsightVisibility>\(_blockInsightVisibility!)</BlockInsightVisibility>") }
	func labelSpecification() -> String { return (_labelSpecification == nil ? "" : "<LabelSpecification>\(_labelSpecification!)</LabelSpecification>") }
	func shippingDocumentSpecification() -> String { return (_shippingDocumentSpecification == nil ? "" : "<ShippingDocumentSpecification>\(_shippingDocumentSpecification!)</ShippingDocumentSpecification>") }
	func rateRequestTypes() -> String { return (_rateRequestTypes == nil ? "" : "<RateRequestTypes>\(_rateRequestTypes!)</RateRequestTypes>") }
	func edtRequestType() -> String { return (_edtRequestType == nil ? "" : "<EdtRequestType>\(_edtRequestType!)</EdtRequestType>") }
	func packageCount() -> String { return (_packageCount == nil ? "" : "<PackageCount>\(_packageCount!)</PackageCount>") }
	func shipmentOnlyFields() -> String { return (_shipmentOnlyFields == nil ? "" : "<ShipmentOnlyFields>\(_shipmentOnlyFields!)</ShipmentOnlyFields>") }
	func configurationData() -> String { return (_configurationData == nil ? "" : "<ConfigurationData>\(_configurationData!)</ConfigurationData>") }
	func requestedPackageLineItems() -> String { return (_requestedPackageLineItems == nil ? "" : "\((_requestedPackageLineItems?.map{ "<RequestedPackageLineItems>\($0)</RequestedPackageLineItems>" } as [String]?)!.joined())") }
	//func requestedPackageLineItems() -> String { return (_requestedPackageLineItems == nil ? "" : "<RequestedPackageLineItems>\(_requestedPackageLineItems!)</RequestedPackageLineItems>") }
}

final class RequestedPackageLineItem : CustomStringConvertible
{
	let _sequenceNumber: Int?
	let _groupNumber: Int?
	let _groupPackageCount: Int?
	let _variableHandlingChargeDetail: VariableHandlingChargeDetail?
	let _insuredValue: Money?
	let _weight: Weight?
	let _dimensions: Dimensions?
	let _physicalPackaging: PhysicalPackagingType?
	let _itemDescription: String?
	let _itemDescriptionForClearance: String?
	let _customerReferences: CustomerReference?
	let _specialServicesRequested: PackageSpecialServicesRequested?
	let _contentRecords: ContentRecord?
	
	var description: String { return "\(sequenceNumber())\(groupNumber())\(groupPackageCount())\(variableHandlingChargeDetail())\(insuredValue())\(weight())\(dimensions())\(physicalPackaging())\(itemDescription())\(itemDescriptionForClearance())\(customerReferences())\(specialServicesRequested())\(contentRecords())" }
	
	init(sequenceNumber: Int?, groupNumber: Int?, groupPackageCount: Int?, variableHandlingChargeDetail: VariableHandlingChargeDetail?, insuredValue: Money?, weight: Weight?, dimensions: Dimensions?, physicalPackaging: PhysicalPackagingType?, itemDescription: String?, itemDescriptionForClearance: String?, customerReferences: CustomerReference?, specialServicesRequested: PackageSpecialServicesRequested?, contentRecords: ContentRecord?)
	{
		_sequenceNumber = sequenceNumber
		_groupNumber = groupNumber
		_groupPackageCount = groupPackageCount
		_variableHandlingChargeDetail = variableHandlingChargeDetail
		_insuredValue = insuredValue
		_weight = weight
		_dimensions = dimensions
		_physicalPackaging = physicalPackaging
		_itemDescription = itemDescription
		_itemDescriptionForClearance = itemDescriptionForClearance
		_customerReferences = customerReferences
		_specialServicesRequested = specialServicesRequested
		_contentRecords = contentRecords
	}
	
	fileprivate func sequenceNumber() -> String { return (_sequenceNumber == nil ? "" : "<SequenceNumber>\(_sequenceNumber!)</SequenceNumber>") }
	fileprivate func groupNumber() -> String { return (_groupNumber == nil ? "" : "<GroupNumber>\(_groupNumber!)</GroupNumber>") }
	fileprivate func groupPackageCount() -> String { return (_groupPackageCount == nil ? "" : "<GroupPackageCount>\(_groupPackageCount!)</GroupPackageCount>") }
	fileprivate func variableHandlingChargeDetail() -> String { return (_variableHandlingChargeDetail == nil ? "" : "<VariableHandlingChargeDetail>\(_variableHandlingChargeDetail!)</VariableHandlingChargeDetail>") }
	fileprivate func insuredValue() -> String { return (_insuredValue == nil ? "" : "<InsuredValue>\(_insuredValue!)</InsuredValue>") }
	fileprivate func weight() -> String { return (_weight == nil ? "" : "<Weight>\(_weight!)</Weight>") }
	fileprivate func dimensions() -> String { return (_dimensions == nil ? "" : "<Dimensions>\(_dimensions!)</Dimensions>") }
	fileprivate func physicalPackaging() -> String { return (_physicalPackaging == nil ? "" : "<PhysicalPackaging>\(_physicalPackaging!)</PhysicalPackaging>") }
	fileprivate func itemDescription() -> String { return (_itemDescription == nil ? "" : "<ItemDescription>\(_itemDescription!)</ItemDescription>") }
	fileprivate func itemDescriptionForClearance() -> String { return (_itemDescriptionForClearance == nil ? "" : "<ItemDescriptionForClearance>\(_itemDescriptionForClearance!)</ItemDescriptionForClearance>") }
	fileprivate func customerReferences() -> String { return (_customerReferences == nil ? "" : "<CustomerReferences>\(_customerReferences!)</CustomerReferences>") }
	fileprivate func specialServicesRequested() -> String { return (_specialServicesRequested == nil ? "" : "<SpecialServicesRequested>\(_specialServicesRequested!)</SpecialServicesRequested>") }
	fileprivate func contentRecords() -> String { return (_contentRecords == nil ? "" : "<ContentRecords>\(_contentRecords!)</ContentRecords>") }
}

struct ShipmentVariationOptionDetail : CustomStringConvertible
{
	fileprivate let _id: String
	fileprivate let _values: String
	
	var description: String { return "\(id())\(values())" }
	
	init(id: String, values: String)
	{
		_id = id
		_values = values
	}
	
	func id() -> String { return "<Id>\(_id)</Id>" }
	func values() -> String { return "<Values>\(_values)</Values>" }
}

struct ShipmentAuthorizationDetail : CustomStringConvertible
{
	fileprivate let _accountNumber: String?
	
	var description: String { return "\(accountNumber())" }
	
	init(accountNumber: String)
	{
		_accountNumber = accountNumber
	}
	
	func accountNumber() -> String { return (_accountNumber == nil ? "" : "<AccountNumber>\(_accountNumber!)</AccountNumber>") }
}

final class TaxpayerIdentification : CustomStringConvertible
{
	fileprivate let _tinType: TinType?
	fileprivate let _number: String?
	fileprivate let _usage: String?
	fileprivate let _effectiveDate: Date?
	fileprivate let _expirationDate: Date?
	
	var description: String { return "\(tinType())\(number())\(usage())\(effectiveDate())\(expirationDate())" }
	
	init(tinType: TinType?, number: String?, usage: String?, effectiveDate: Date?, expirationDate: Date?)
	{
		_tinType = tinType
		_number = number
		_usage = usage
		_effectiveDate = effectiveDate
		_expirationDate = expirationDate
	}
	
	func tinType() -> String { return (_tinType == nil ? "" : "<TinType>\(_tinType!)</TinType>") }
	func number() -> String { return (_number == nil ? "" : "<Number>\(_number!)</Number>") }
	func usage() -> String { return (_usage == nil ? "" : "<Usage>\(_usage!)</Usage>") }
	func effectiveDate() -> String { return (_effectiveDate == nil ? "" : "<EffectiveDate>\(_effectiveDate!)</EffectiveDate>") }
	func expirationDate() -> String { return (_expirationDate == nil ? "" : "<ExpirationDate>\(_expirationDate!)</ExpirationDate>") }
}

struct Contact : CustomStringConvertible
{
	fileprivate let _contactId: String?
	fileprivate let _personName: String?
	fileprivate let _title: String?
	fileprivate let _companyName: String?
	fileprivate let _phoneNumber: String?
	fileprivate let _phoneExtension: String?
	fileprivate let _tollFreePhoneNumber: String?
	fileprivate let _pagerNumber: String?
	fileprivate let _faxNumber: String?
	fileprivate let _eMailAddress: String?
	
	var description: String { return "\(contactId())\(personName())\(title())\(companyName())\(phoneNumber())\(phoneExtension())\(tollFreePhoneNumber())\(pagerNumber())\(faxNumber())\(eMailAddress())" }
	
	init(contactId: String?, personName: String?, title: String?, companyName: String?, phoneNumber: String?, phoneExtension: String?, tollFreePhoneNumber: String?, pagerNumber: String?, faxNumber: String?, eMailAddress: String?)
	{
		_contactId = contactId
		_personName = personName
		_title = title
		_companyName = companyName
		_phoneNumber = phoneNumber
		_phoneExtension = phoneExtension
		_tollFreePhoneNumber = tollFreePhoneNumber
		_pagerNumber = pagerNumber
		_faxNumber = faxNumber
		_eMailAddress = eMailAddress
	}
	
	func contactId() -> String { return (_contactId == nil ? "" : "<ContactId>\(_contactId!)</ContactId>") }
	func personName() -> String { return (_personName == nil ? "" : "<PersonName>\(_personName!)</PersonName>") }
	func title() -> String { return (_title == nil ? "" : "<Title>\(_title!)</Title>") }
	func companyName() -> String { return (_companyName == nil ? "" : "<CompanyName>\(_companyName!)</CompanyName>") }
	func phoneNumber() -> String { return (_phoneNumber == nil ? "" : "<PhoneNumber>\(_phoneNumber!)</PhoneNumber>") }
	func phoneExtension() -> String { return (_phoneExtension == nil ? "" : "<PhoneExtension>\(_phoneExtension!)</PhoneExtension>") }
	func tollFreePhoneNumber() -> String { return (_tollFreePhoneNumber == nil ? "" : "<TollFreePhoneNumber>\(_tollFreePhoneNumber!)</TollFreePhoneNumber>") }
	func pagerNumber() -> String { return (_pagerNumber == nil ? "" : "<PagerNumber>\(_pagerNumber!)</PagerNumber>") }
	func faxNumber() -> String { return (_faxNumber == nil ? "" : "<FaxNumber>\(_faxNumber!)</FaxNumber>") }
	func eMailAddress() -> String { return (_eMailAddress == nil ? "" : "<EMailAddress>\(_eMailAddress!)</EMailAddress>") }
}

final class Party : CustomStringConvertible
{
	fileprivate let _accountNumber: String?
	fileprivate let _tins: TaxpayerIdentification?
	fileprivate let _contact: Contact?
	fileprivate let _address: Address?
	
	var description: String { return "\(accountNumber())\(tins())\(contact())\(address())" }
	
	init(accountNumber: String?, tins: TaxpayerIdentification?, contact: Contact?, address: Address?)
	{
		_accountNumber = accountNumber
		_tins = tins
		_contact = contact
		_address = address
	}
	
	func accountNumber() -> String { return (_accountNumber == nil ? "" : "<AccountNumber>\(_accountNumber!)</AccountNumber>") }
	func tins() -> String { return (_tins == nil ? "" : "<Tins>\(_tins!)</Tins>") }
	func contact() -> String { return (_contact == nil ? "" : "<Contact>\(_contact!)</Contact>") }
	func address() -> String { return (_address == nil ? "" : "<Address>\(_address!)</Address>") }
}

final class ContactAndAddress : CustomStringConvertible
{
	fileprivate let _contact: Contact?
	fileprivate let _address: Address?
	
	var description: String { return "\(contact())\(address())" }
	
	init(contact: Contact?, address: Address?)
	{
		_contact = contact
		_address = address
	}
	
	func contact() -> String { return (_contact == nil ? "" : "<Contact>\(_contact!)</Contact>") }
	func address() -> String { return (_address == nil ? "" : "<Address>\(_address!)</Address>") }
}

final class Payment : CustomStringConvertible
{
	fileprivate let _paymentType: PaymentType?
	fileprivate let _payor: Payor?
	
	var description: String { return "\(paymentType())\(payor())" }
	
	init(paymentType: PaymentType?, payor: Payor?)
	{
		_paymentType = paymentType
		_payor = payor
	}
	
	func paymentType() -> String { return (_paymentType == nil ? "" : "<PaymentType>\(_paymentType!)</PaymentType>") }
	func payor() -> String { return (_payor == nil ? "" : "<Payor>\(_payor!)</Payor>") }
}

final class Payor : CustomStringConvertible
{
	fileprivate let _responsibleParty: Party?
	
	var description: String { return "\(responsibleParty())" }
	
	init(responsibleParty: Party?)
	{
		_responsibleParty = responsibleParty
	}
	
	func responsibleParty() -> String { return (_responsibleParty == nil ? "" : "<ResponsibleParty>\(_responsibleParty!)</ResponsibleParty>") }
}

final class ShipmentSpecialServicesRequested : CustomStringConvertible
{
	fileprivate let _specialServiceTypes: [ShipmentSpecialServiceType]
	fileprivate let _codDetail: CodDetail?
	fileprivate let _deliveryOnInvoiceAcceptanceDetail: DeliveryOnInvoiceAcceptanceDetail?
	fileprivate let _holdAtLocationDetail: HoldAtLocationDetail?
	fileprivate let _eventNotificationDetail: ShipmentEventNotificationDetail?
	fileprivate let _returnShipmentDetail: ReturnShipmentDetail?
	fileprivate let _pendingShipmentDetail: PendingShipmentDetail?
	fileprivate let _internationalControlledExportDetail: InternationalControlledExportDetail?
	fileprivate let _internationalTrafficInArmsRegulationsDetail: InternationalTrafficInArmsRegulationsDetail?
	fileprivate let _shipmentDryIceDetail: ShipmentDryIceDetail?
	fileprivate let _homeDeliveryPremiumDetail: HomeDeliveryPremiumDetail?
	fileprivate let _flatbedTrailerDetail: FlatbedTrailerDetail?
	fileprivate let _freightGuaranteeDetail: FreightGuaranteeDetail?
	fileprivate let _etdDetail: EtdDetail?
	fileprivate let _customDeliveryWindowDetail: CustomDeliveryWindowDetail?
	
	var description: String { return "\(specialServiceTypes())\(codDetail())\(deliveryOnInvoiceAcceptanceDetail())\(holdAtLocationDetail())\(eventNotificationDetail())\(returnShipmentDetail())\(pendingShipmentDetail())\(internationalControlledExportDetail())\(internationalTrafficInArmsRegulationsDetail())\(shipmentDryIceDetail())\(homeDeliveryPremiumDetail())\(flatbedTrailerDetail())\(freightGuaranteeDetail())\(etdDetail())\(customDeliveryWindowDetail())" }
	
	init(specialServiceTypes: [ShipmentSpecialServiceType], codDetail: CodDetail?, deliveryOnInvoiceAcceptanceDetail: DeliveryOnInvoiceAcceptanceDetail?, holdAtLocationDetail: HoldAtLocationDetail?, eventNotificationDetail: ShipmentEventNotificationDetail?, returnShipmentDetail: ReturnShipmentDetail?, pendingShipmentDetail: PendingShipmentDetail?, internationalControlledExportDetail: InternationalControlledExportDetail?, internationalTrafficInArmsRegulationsDetail: InternationalTrafficInArmsRegulationsDetail?, shipmentDryIceDetail: ShipmentDryIceDetail?, homeDeliveryPremiumDetail: HomeDeliveryPremiumDetail?, flatbedTrailerDetail: FlatbedTrailerDetail?, freightGuaranteeDetail: FreightGuaranteeDetail?, etdDetail: EtdDetail?, customDeliveryWindowDetail: CustomDeliveryWindowDetail?)
	{
		_specialServiceTypes = specialServiceTypes
		_codDetail = codDetail
		_deliveryOnInvoiceAcceptanceDetail = deliveryOnInvoiceAcceptanceDetail
		_holdAtLocationDetail = holdAtLocationDetail
		_eventNotificationDetail = eventNotificationDetail
		_returnShipmentDetail = returnShipmentDetail
		_pendingShipmentDetail = pendingShipmentDetail
		_internationalControlledExportDetail = internationalControlledExportDetail
		_internationalTrafficInArmsRegulationsDetail = internationalTrafficInArmsRegulationsDetail
		_shipmentDryIceDetail = shipmentDryIceDetail
		_homeDeliveryPremiumDetail = homeDeliveryPremiumDetail
		_flatbedTrailerDetail = flatbedTrailerDetail
		_freightGuaranteeDetail = freightGuaranteeDetail
		_etdDetail = etdDetail
		_customDeliveryWindowDetail = customDeliveryWindowDetail
	}
	
	func specialServiceTypes() -> String { return "\((_specialServiceTypes.map{ "<SpecialServiceTypes>\($0)</SpecialServiceTypes>" } as [String]).joined())" }
	func codDetail() -> String { return (_codDetail == nil ? "" : "<CodDetail>\(_codDetail!)</CodDetail>") }
	func deliveryOnInvoiceAcceptanceDetail() -> String { return (_deliveryOnInvoiceAcceptanceDetail == nil ? "" : "<DeliveryOnInvoiceAcceptanceDetail>\(_deliveryOnInvoiceAcceptanceDetail!)</DeliveryOnInvoiceAcceptanceDetail>") }
	func holdAtLocationDetail() -> String { return (_holdAtLocationDetail == nil ? "" : "<HoldAtLocationDetail>\(_holdAtLocationDetail!)</HoldAtLocationDetail>") }
	func eventNotificationDetail() -> String { return (_eventNotificationDetail == nil ? "" : "<EventNotificationDetail>\(_eventNotificationDetail!)</EventNotificationDetail>") }
	func returnShipmentDetail() -> String { return (_returnShipmentDetail == nil ? "" : "<ReturnShipmentDetail>\(_returnShipmentDetail!)</ReturnShipmentDetail>") }
	func pendingShipmentDetail() -> String { return (_pendingShipmentDetail == nil ? "" : "<PendingShipmentDetail>\(_pendingShipmentDetail!)</PendingShipmentDetail>") }
	func internationalControlledExportDetail() -> String { return (_internationalControlledExportDetail == nil ? "" : "<InternationalControlledExportDetail>\(_internationalControlledExportDetail!)</InternationalControlledExportDetail>") }
	func internationalTrafficInArmsRegulationsDetail() -> String { return (_internationalTrafficInArmsRegulationsDetail == nil ? "" : "<InternationalTrafficInArmsRegulationsDetail>\(_internationalTrafficInArmsRegulationsDetail!)</InternationalTrafficInArmsRegulationsDetail>") }
	func shipmentDryIceDetail() -> String { return (_shipmentDryIceDetail == nil ? "" : "<ShipmentDryIceDetail>\(_shipmentDryIceDetail!)</ShipmentDryIceDetail>") }
	func homeDeliveryPremiumDetail() -> String { return (_homeDeliveryPremiumDetail == nil ? "" : "<HomeDeliveryPremiumDetail>\(_homeDeliveryPremiumDetail!)</HomeDeliveryPremiumDetail>") }
	func flatbedTrailerDetail() -> String { return (_flatbedTrailerDetail == nil ? "" : "<FlatbedTrailerDetail>\(_flatbedTrailerDetail!)</FlatbedTrailerDetail>") }
	func freightGuaranteeDetail() -> String { return (_freightGuaranteeDetail == nil ? "" : "<FreightGuaranteeDetail>\(_freightGuaranteeDetail!)</FreightGuaranteeDetail>") }
	func etdDetail() -> String { return (_etdDetail == nil ? "" : "<EtdDetail>\(_etdDetail!)</EtdDetail>") }
	func customDeliveryWindowDetail() -> String { return (_customDeliveryWindowDetail == nil ? "" : "<CustomDeliveryWindowDetail>\(_customDeliveryWindowDetail!)</CustomDeliveryWindowDetail>") }
}

final class DeliveryOnInvoiceAcceptanceDetail : CustomStringConvertible
{
	fileprivate let _recipient: Party?
	fileprivate let _trackingId: TrackingId?
	
	var description: String { return "\(recipient())\(trackingId())" }
	
	init(recipient: Party?, trackingId: TrackingId?)
	{
		_recipient = recipient
		_trackingId = trackingId
	}
	
	func recipient() -> String { return (_recipient == nil ? "" : "<Recipient>\(_recipient!)</Recipient>") }
	func trackingId() -> String { return (_trackingId == nil ? "" : "<TrackingId>\(_trackingId!)</TrackingId>") }
}

final class HoldAtLocationDetail : CustomStringConvertible
{
	fileprivate let _phoneNumber: String?
	fileprivate let _locationContactAndAddress: ContactAndAddress?
	fileprivate let _locationType: FedExLocationType?
	fileprivate let _locationId: String?
	fileprivate let _locationNumber: Int?
	
	var description: String { return "\(phoneNumber())\(locationContactAndAddress())\(locationType())\(locationId())\(locationNumber())" }
	
	init(phoneNumber: String?, locationContactAndAddress: ContactAndAddress?, locationType: FedExLocationType?, locationId: String?, locationNumber: Int?)
	{
		_phoneNumber = phoneNumber
		_locationContactAndAddress = locationContactAndAddress
		_locationType = locationType
		_locationId = locationId
		_locationNumber = locationNumber
	}
	
	func phoneNumber() -> String { return (_phoneNumber == nil ? "" : "<PhoneNumber>\(_phoneNumber!)</PhoneNumber>") }
	func locationContactAndAddress() -> String { return (_locationContactAndAddress == nil ? "" : "<LocationContactAndAddress>\(_locationContactAndAddress!)</LocationContactAndAddress>") }
	func locationType() -> String { return (_locationType == nil ? "" : "<LocationType>\(_locationType!)</LocationType>") }
	func locationId() -> String { return (_locationId == nil ? "" : "<LocationId>\(_locationId!)</LocationId>") }
	func locationNumber() -> String { return (_locationNumber == nil ? "" : "<LocationNumber>\(_locationNumber!)</LocationNumber>") }
}

final class ShipmentEventNotificationDetail : CustomStringConvertible
{
	fileprivate let _aggregationType: ShipmentNotificationAggregationType?
	fileprivate let _personalMessage: String?
	fileprivate let _eventNotifications: ShipmentEventNotificationSpecification?
	
	var description: String { return "\(aggregationType())\(personalMessage())\(eventNotifications())" }
	
	init(aggregationType: ShipmentNotificationAggregationType?, personalMessage: String?, eventNotifications: ShipmentEventNotificationSpecification?)
	{
		_aggregationType = aggregationType
		_personalMessage = personalMessage
		_eventNotifications = eventNotifications
	}
	
	func aggregationType() -> String { return (_aggregationType == nil ? "" : "<AggregationType>\(_aggregationType!)</AggregationType>") }
	func personalMessage() -> String { return (_personalMessage == nil ? "" : "<PersonalMessage>\(_personalMessage!)</PersonalMessage>") }
	func eventNotifications() -> String { return (_eventNotifications == nil ? "" : "<EventNotifications>\(_eventNotifications!)</EventNotifications>") }
}

final class ShipmentEventNotificationSpecification : CustomStringConvertible
{
	fileprivate let _role: ShipmentNotificationRoleType?
	fileprivate let _events: NotificationEventType?
	fileprivate let _notificationDetail: NotificationDetail?
	fileprivate let _formatSpecification: ShipmentNotificationFormatSpecification?
	
	var description: String { return "\(role())\(events())\(notificationDetail())\(formatSpecification())" }
	
	init(role: ShipmentNotificationRoleType?, events: NotificationEventType?, notificationDetail: NotificationDetail?, formatSpecification: ShipmentNotificationFormatSpecification?)
	{
		_role = role
		_events = events
		_notificationDetail = notificationDetail
		_formatSpecification = formatSpecification
	}
	
	func role() -> String { return (_role == nil ? "" : "<Role>\(_role!)</Role>") }
	func events() -> String { return (_events == nil ? "" : "<Events>\(_events!)</Events>") }
	func notificationDetail() -> String { return (_notificationDetail == nil ? "" : "<NotificationDetail>\(_notificationDetail!)</NotificationDetail>") }
	func formatSpecification() -> String { return (_formatSpecification == nil ? "" : "<FormatSpecification>\(_formatSpecification!)</FormatSpecification>") }
}

final class NotificationDetail : CustomStringConvertible
{
	fileprivate let _notificationType: NotificationType?
	fileprivate let _emailDetail: EMailDetail?
	fileprivate let _localization: Localization?
	
	var description: String { return "\(notificationType())\(emailDetail())\(localization())" }
	
	init(notificationType: NotificationType?, emailDetail: EMailDetail?, localization: Localization?)
	{
		_notificationType = notificationType
		_emailDetail = emailDetail
		_localization = localization
	}
	
	func notificationType() -> String { return (_notificationType == nil ? "" : "<NotificationType>\(_notificationType!)</NotificationType>") }
	func emailDetail() -> String { return (_emailDetail == nil ? "" : "<EmailDetail>\(_emailDetail!)</EmailDetail>") }
	func localization() -> String { return (_localization == nil ? "" : "<Localization>\(_localization!)</Localization>") }
}

struct EMailDetail : CustomStringConvertible
{
	fileprivate let _emailAddress: String?
	fileprivate let _name: String?
	
	var description: String { return "\(emailAddress())\(name())" }
	
	init(emailAddress: String?, name: String?)
	{
		_emailAddress = emailAddress
		_name = name
	}
	
	func emailAddress() -> String { return (_emailAddress == nil ? "" : "<EmailAddress>\(_emailAddress!)</EmailAddress>") }
	func name() -> String { return (_name == nil ? "" : "<Name>\(_name!)</Name>") }
}

struct Address : CustomStringConvertible
{
	fileprivate let _streetLines: String?
	fileprivate let _city: String?
	fileprivate let _stateOrProvinceCode: String?
	fileprivate let _postalCode: String?
	fileprivate let _urbanizationCode: String?
	fileprivate let _countryCode: String?
	fileprivate let _countryName: String?
	fileprivate let _residential: Bool?
	
	var description: String { return "\(streetLines())\(city())\(stateOrProvinceCode())\(postalCode())\(urbanizationCode())\(countryCode())\(countryName())\(residential())" }
	
	init(streetLines: String?, city: String?, stateOrProvinceCode: String?, postalCode: String?, urbanizationCode: String?, countryCode: String?, countryName: String?, residential: Bool?)
	{
		_streetLines = streetLines
		_city = city
		_stateOrProvinceCode = stateOrProvinceCode
		_postalCode = postalCode
		_urbanizationCode = urbanizationCode
		_countryCode = countryCode
		_countryName = countryName
		_residential = residential
	}
	
	func streetLines() -> String { return (_streetLines == nil ? "" : "<StreetLines>\(_streetLines!)</StreetLines>") }
	func city() -> String { return (_city == nil ? "" : "<City>\(_city!)</City>") }
	func stateOrProvinceCode() -> String { return (_stateOrProvinceCode == nil ? "" : "<StateOrProvinceCode>\(_stateOrProvinceCode!)</StateOrProvinceCode>") }
	func postalCode() -> String { return (_postalCode == nil ? "" : "<PostalCode>\(_postalCode!)</PostalCode>") }
	func urbanizationCode() -> String { return (_urbanizationCode == nil ? "" : "<UrbanizationCode>\(_urbanizationCode!)</UrbanizationCode>") }
	func countryCode() -> String { return (_countryCode == nil ? "" : "<CountryCode>\(_countryCode!)</CountryCode>") }
	func countryName() -> String { return (_countryName == nil ? "" : "<CountryName>\(_countryName!)</CountryName>") }
	func residential() -> String { return (_residential == nil ? "" : "<Residential>\(_residential!)</Residential>") }
}

final class ShipmentNotificationFormatSpecification : CustomStringConvertible
{
	fileprivate let _type: NotificationFormatType?
	
	var description: String { return "\(type())" }
	
	init(type: NotificationFormatType)
	{
		_type = type
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
}

final class ReturnShipmentDetail : CustomStringConvertible
{
	fileprivate let _returnType: ReturnType?
	fileprivate let _rma: Rma?
	fileprivate let _returnEMailDetail: ReturnEMailDetail?
	fileprivate let _returnAssociation: ReturnAssociationDetail?
	
	var description: String { return "\(returnType())\(rma())\(returnEMailDetail())\(returnAssociation())" }
	
	init(returnType: ReturnType, rma: Rma, returnEMailDetail: ReturnEMailDetail, returnAssociation: ReturnAssociationDetail)
	{
		_returnType = returnType
		_rma = rma
		_returnEMailDetail = returnEMailDetail
		_returnAssociation = returnAssociation
	}
	
	func returnType() -> String { return (_returnType == nil ? "" : "<ReturnType>\(_returnType!)</ReturnType>") }
	func rma() -> String { return (_rma == nil ? "" : "<Rma>\(_rma!)</Rma>") }
	func returnEMailDetail() -> String { return (_returnEMailDetail == nil ? "" : "<ReturnEMailDetail>\(_returnEMailDetail!)</ReturnEMailDetail>") }
	func returnAssociation() -> String { return (_returnAssociation == nil ? "" : "<ReturnAssociation>\(_returnAssociation!)</ReturnAssociation>") }
}

struct Rma : CustomStringConvertible
{
	fileprivate let _reason: String?
	
	var description: String { return "\(reason())" }
	
	init(reason: String)
	{
		_reason = reason
	}
	
	func reason() -> String { return (_reason == nil ? "" : "<Reason>\(_reason!)</Reason>") }
}

final class ReturnEMailDetail : CustomStringConvertible
{
	fileprivate let _merchantPhoneNumber: String?
	fileprivate let _allowedSpecialServices: ReturnEMailAllowedSpecialServiceType?
	
	var description: String { return "\(merchantPhoneNumber())\(allowedSpecialServices())" }
	
	init(merchantPhoneNumber: String, allowedSpecialServices: ReturnEMailAllowedSpecialServiceType)
	{
		_merchantPhoneNumber = merchantPhoneNumber
		_allowedSpecialServices = allowedSpecialServices
	}
	
	func merchantPhoneNumber() -> String { return (_merchantPhoneNumber == nil ? "" : "<MerchantPhoneNumber>\(_merchantPhoneNumber!)</MerchantPhoneNumber>") }
	func allowedSpecialServices() -> String { return (_allowedSpecialServices == nil ? "" : "<AllowedSpecialServices>\(_allowedSpecialServices!)</AllowedSpecialServices>") }
}

struct ReturnAssociationDetail : CustomStringConvertible
{
	fileprivate let _trackingNumber: String?
	fileprivate let _shipDate: Date?
	
	var description: String { return "\(trackingNumber())\(shipDate())" }
	
	init(trackingNumber: String, shipDate: Date)
	{
		_trackingNumber = trackingNumber
		_shipDate = shipDate
	}
	
	func trackingNumber() -> String { return (_trackingNumber == nil ? "" : "<TrackingNumber>\(_trackingNumber!)</TrackingNumber>") }
	func shipDate() -> String { return (_shipDate == nil ? "" : "<ShipDate>\(_shipDate!)</ShipDate>") }
}

final class PendingShipmentDetail : CustomStringConvertible
{
	fileprivate let _type: PendingShipmentType?
	fileprivate let _expirationDate: Date?
	fileprivate let _processingOptions: PendingShipmentProcessingOptionsRequested?
	fileprivate let _recommendedDocumentSpecification: RecommendedDocumentSpecification?
	
	var description: String { return "\(type())\(expirationDate())\(processingOptions())\(recommendedDocumentSpecification())" }
	
	init(type: PendingShipmentType, expirationDate: Date, processingOptions: PendingShipmentProcessingOptionsRequested, recommendedDocumentSpecification: RecommendedDocumentSpecification)
	{
		_type = type
		_expirationDate = expirationDate
		_processingOptions = processingOptions
		_recommendedDocumentSpecification = recommendedDocumentSpecification
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func expirationDate() -> String { return (_expirationDate == nil ? "" : "<ExpirationDate>\(_expirationDate!)</ExpirationDate>") }
	func processingOptions() -> String { return (_processingOptions == nil ? "" : "<ProcessingOptions>\(_processingOptions!)</ProcessingOptions>") }
	func recommendedDocumentSpecification() -> String { return (_recommendedDocumentSpecification == nil ? "" : "<RecommendedDocumentSpecification>\(_recommendedDocumentSpecification!)</RecommendedDocumentSpecification>") }
}

final class PendingShipmentProcessingOptionsRequested : CustomStringConvertible
{
	fileprivate let _options: PendingShipmentProcessingOptionType?
	
	var description: String { return "\(options())" }
	
	init(options: PendingShipmentProcessingOptionType)
	{
		_options = options
	}
	
	func options() -> String { return (_options == nil ? "" : "<Options>\(_options!)</Options>") }
}

final class RecommendedDocumentSpecification : CustomStringConvertible
{
	fileprivate let _types: RecommendedDocumentType?
	
	var description: String { return "\(types())" }
	
	init(types: RecommendedDocumentType)
	{
		_types = types
	}
	
	func types() -> String { return (_types == nil ? "" : "<Types>\(_types!)</Types>") }
}

final class InternationalControlledExportDetail : CustomStringConvertible
{
	fileprivate let _type: InternationalControlledExportType?
	fileprivate let _foreignTradeZoneCode: String?
	fileprivate let _entryNumber: String?
	fileprivate let _licenseOrPermitNumber: String?
	fileprivate let _licenseOrPermitExpirationDate: Date?
	
	var description: String { return "\(type())\(foreignTradeZoneCode())\(entryNumber())\(licenseOrPermitNumber())\(licenseOrPermitExpirationDate())" }
	
	init(type: InternationalControlledExportType, foreignTradeZoneCode: String, entryNumber: String, licenseOrPermitNumber: String, licenseOrPermitExpirationDate: Date)
	{
		_type = type
		_foreignTradeZoneCode = foreignTradeZoneCode
		_entryNumber = entryNumber
		_licenseOrPermitNumber = licenseOrPermitNumber
		_licenseOrPermitExpirationDate = licenseOrPermitExpirationDate
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func foreignTradeZoneCode() -> String { return (_foreignTradeZoneCode == nil ? "" : "<ForeignTradeZoneCode>\(_foreignTradeZoneCode!)</ForeignTradeZoneCode>") }
	func entryNumber() -> String { return (_entryNumber == nil ? "" : "<EntryNumber>\(_entryNumber!)</EntryNumber>") }
	func licenseOrPermitNumber() -> String { return (_licenseOrPermitNumber == nil ? "" : "<LicenseOrPermitNumber>\(_licenseOrPermitNumber!)</LicenseOrPermitNumber>") }
	func licenseOrPermitExpirationDate() -> String { return (_licenseOrPermitExpirationDate == nil ? "" : "<LicenseOrPermitExpirationDate>\(_licenseOrPermitExpirationDate!)</LicenseOrPermitExpirationDate>") }
}

struct InternationalTrafficInArmsRegulationsDetail : CustomStringConvertible
{
	fileprivate let _licenseOrExemptionNumber: String?
	
	var description: String { return "\(licenseOrExemptionNumber())" }
	
	init(licenseOrExemptionNumber: String)
	{
		_licenseOrExemptionNumber = licenseOrExemptionNumber
	}
	
	func licenseOrExemptionNumber() -> String { return (_licenseOrExemptionNumber == nil ? "" : "<LicenseOrExemptionNumber>\(_licenseOrExemptionNumber!)</LicenseOrExemptionNumber>") }
}

final class ShipmentDryIceDetail : CustomStringConvertible
{
	fileprivate let _packageCount: UInt?
	fileprivate let _totalWeight: Weight?
	fileprivate let _processingOptions: ShipmentDryIceProcessingOptionsRequested?
	
	var description: String { return "\(packageCount())\(totalWeight())\(processingOptions())" }
	
	init(packageCount: UInt, totalWeight: Weight, processingOptions: ShipmentDryIceProcessingOptionsRequested)
	{
		_packageCount = packageCount
		_totalWeight = totalWeight
		_processingOptions = processingOptions
	}
	
	func packageCount() -> String { return (_packageCount == nil ? "" : "<PackageCount>\(_packageCount!)</PackageCount>") }
	func totalWeight() -> String { return (_totalWeight == nil ? "" : "<TotalWeight>\(_totalWeight!)</TotalWeight>") }
	func processingOptions() -> String { return (_processingOptions == nil ? "" : "<ProcessingOptions>\(_processingOptions!)</ProcessingOptions>") }
}

final class ShipmentDryIceProcessingOptionsRequested : CustomStringConvertible
{
	fileprivate let _options: ShipmentDryIceProcessingOptionType?
	
	var description: String { return "\(options())" }
	
	init(options: ShipmentDryIceProcessingOptionType)
	{
		_options = options
	}
	
	func options() -> String { return (_options == nil ? "" : "<Options>\(_options!)</Options>") }
}

final class HomeDeliveryPremiumDetail : CustomStringConvertible
{
	fileprivate let _homeDeliveryPremiumType: HomeDeliveryPremiumType?
	fileprivate let _date: Date?
	fileprivate let _phoneNumber: String?
	
	var description: String { return "\(homeDeliveryPremiumType())\(date())\(phoneNumber())" }
	
	init(homeDeliveryPremiumType: HomeDeliveryPremiumType, date: Date, phoneNumber: String)
	{
		_homeDeliveryPremiumType = homeDeliveryPremiumType
		_date = date
		_phoneNumber = phoneNumber
	}
	
	func homeDeliveryPremiumType() -> String { return (_homeDeliveryPremiumType == nil ? "" : "<HomeDeliveryPremiumType>\(_homeDeliveryPremiumType!)</HomeDeliveryPremiumType>") }
	func date() -> String { return (_date == nil ? "" : "<Date>\(formatDate(_date!))</Date>") }
	func phoneNumber() -> String { return (_phoneNumber == nil ? "" : "<PhoneNumber>\(_phoneNumber!)</PhoneNumber>") }
}

final class FlatbedTrailerDetail : CustomStringConvertible
{
	fileprivate let _options: FlatbedTrailerOption?
	
	var description: String { return "\(options())" }
	
	init(options: FlatbedTrailerOption)
	{
		_options = options
	}
	
	func options() -> String { return (_options == nil ? "" : "<Options>\(_options!)</Options>") }
}

final class FreightGuaranteeDetail : CustomStringConvertible
{
	fileprivate let _type: FreightGuaranteeType?
	fileprivate let _date: Date?
	
	var description: String { return "\(type())\(date())" }
	
	init(type: FreightGuaranteeType, date: Date)
	{
		_type = type
		_date = date
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func date() -> String { return (_date == nil ? "" : "<Date>\(formatDate(_date!))</Date>") }
}

final class EtdDetail : CustomStringConvertible
{
	fileprivate let _requestedDocumentCopies: RequestedShippingDocumentType?
	fileprivate let _documentReferences: UploadDocumentReferenceDetail?
	
	var description: String { return "\(requestedDocumentCopies())\(documentReferences())" }
	
	init(requestedDocumentCopies: RequestedShippingDocumentType, documentReferences: UploadDocumentReferenceDetail)
	{
		_requestedDocumentCopies = requestedDocumentCopies
		_documentReferences = documentReferences
	}
	
	func requestedDocumentCopies() -> String { return (_requestedDocumentCopies == nil ? "" : "<RequestedDocumentCopies>\(_requestedDocumentCopies!)</RequestedDocumentCopies>") }
	func documentReferences() -> String { return (_documentReferences == nil ? "" : "<DocumentReferences>\(_documentReferences!)</DocumentReferences>") }
}

final class UploadDocumentReferenceDetail : CustomStringConvertible
{
	fileprivate let _lineNumber: UInt?
	fileprivate let _customerReference: String?
	fileprivate let _description: String?
	fileprivate let _documentProducer: UploadDocumentProducerType?
	fileprivate let _documentType: UploadDocumentType?
	fileprivate let _documentId: String?
	fileprivate let _documentIdProducer: UploadDocumentIdProducer?
	
	var description: String { return "\(lineNumber())\(customerReference())\(description_())\(documentProducer())\(documentType())\(documentId())\(documentIdProducer())" }
	
	init(lineNumber: UInt, customerReference: String, description: String, documentProducer: UploadDocumentProducerType, documentType: UploadDocumentType, documentId: String, documentIdProducer: UploadDocumentIdProducer)
	{
		_lineNumber = lineNumber
		_customerReference = customerReference
		_description = description
		_documentProducer = documentProducer
		_documentType = documentType
		_documentId = documentId
		_documentIdProducer = documentIdProducer
	}
	
	func lineNumber() -> String { return (_lineNumber == nil ? "" : "<LineNumber>\(_lineNumber!)</LineNumber>") }
	func customerReference() -> String { return (_customerReference == nil ? "" : "<CustomerReference>\(_customerReference!)</CustomerReference>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func documentProducer() -> String { return (_documentProducer == nil ? "" : "<DocumentProducer>\(_documentProducer!)</DocumentProducer>") }
	func documentType() -> String { return (_documentType == nil ? "" : "<DocumentType>\(_documentType!)</DocumentType>") }
	func documentId() -> String { return (_documentId == nil ? "" : "<DocumentId>\(_documentId!)</DocumentId>") }
	func documentIdProducer() -> String { return (_documentIdProducer == nil ? "" : "<DocumentIdProducer>\(_documentIdProducer!)</DocumentIdProducer>") }
}

final class CustomDeliveryWindowDetail : CustomStringConvertible
{
	fileprivate let _type: CustomDeliveryWindowType?
	fileprivate let _requestTime: Date?
	fileprivate let _requestRange: DateRange?
	fileprivate let _requestDate: Date?
	
	var description: String { return "\(type())\(requestTime())\(requestRange())\(requestDate())" }
	
	init(type: CustomDeliveryWindowType, requestTime: Date, requestRange: DateRange, requestDate: Date)
	{
		_type = type
		_requestTime = requestTime
		_requestRange = requestRange
		_requestDate = requestDate
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func requestTime() -> String { return (_requestTime == nil ? "" : "<RequestTime>\(_requestTime!)</RequestTime>") }
	func requestRange() -> String { return (_requestRange == nil ? "" : "<RequestRange>\(_requestRange!)</RequestRange>") }
	func requestDate() -> String { return (_requestDate == nil ? "" : "<RequestDate>\(_requestDate!)</RequestDate>") }
}

struct DateRange : CustomStringConvertible
{
	fileprivate let _begins: Date?
	fileprivate let _ends: Date?
	
	var description: String { return "\(begins())\(ends())" }
	
	init(begins: Date, ends: Date)
	{
		_begins = begins
		_ends = ends
	}
	
	func begins() -> String { return (_begins == nil ? "" : "<Begins>\(_begins!)</Begins>") }
	func ends() -> String { return (_ends == nil ? "" : "<Ends>\(_ends!)</Ends>") }
}

final class ExpressFreightDetail : CustomStringConvertible
{
	fileprivate let _packingListEnclosed: Bool?
	fileprivate let _shippersLoadAndCount: Int?
	fileprivate let _bookingConfirmationNumber: String?
	fileprivate let _referenceLabelRequested: Bool?
	fileprivate let _beforeDeliveryContact: ExpressFreightDetailContact?
	fileprivate let _undeliverableContact: ExpressFreightDetailContact?
	
	var description: String { return "\(packingListEnclosed())\(shippersLoadAndCount())\(bookingConfirmationNumber())\(referenceLabelRequested())\(beforeDeliveryContact())\(undeliverableContact())" }
	
	init(packingListEnclosed: Bool, shippersLoadAndCount: Int, bookingConfirmationNumber: String, referenceLabelRequested: Bool, beforeDeliveryContact: ExpressFreightDetailContact, undeliverableContact: ExpressFreightDetailContact)
	{
		_packingListEnclosed = packingListEnclosed
		_shippersLoadAndCount = shippersLoadAndCount
		_bookingConfirmationNumber = bookingConfirmationNumber
		_referenceLabelRequested = referenceLabelRequested
		_beforeDeliveryContact = beforeDeliveryContact
		_undeliverableContact = undeliverableContact
	}
	
	func packingListEnclosed() -> String { return (_packingListEnclosed == nil ? "" : "<PackingListEnclosed>\(_packingListEnclosed!)</PackingListEnclosed>") }
	func shippersLoadAndCount() -> String { return (_shippersLoadAndCount == nil ? "" : "<ShippersLoadAndCount>\(_shippersLoadAndCount!)</ShippersLoadAndCount>") }
	func bookingConfirmationNumber() -> String { return (_bookingConfirmationNumber == nil ? "" : "<BookingConfirmationNumber>\(_bookingConfirmationNumber!)</BookingConfirmationNumber>") }
	func referenceLabelRequested() -> String { return (_referenceLabelRequested == nil ? "" : "<ReferenceLabelRequested>\(_referenceLabelRequested!)</ReferenceLabelRequested>") }
	func beforeDeliveryContact() -> String { return (_beforeDeliveryContact == nil ? "" : "<BeforeDeliveryContact>\(_beforeDeliveryContact!)</BeforeDeliveryContact>") }
	func undeliverableContact() -> String { return (_undeliverableContact == nil ? "" : "<UndeliverableContact>\(_undeliverableContact!)</UndeliverableContact>") }
}

struct ExpressFreightDetailContact : CustomStringConvertible
{
	fileprivate let _name: String?
	fileprivate let _phone: String?
	
	var description: String { return "\(name())\(phone())" }
	
	init(name: String, phone: String)
	{
		_name = name
		_phone = phone
	}
	
	func name() -> String { return (_name == nil ? "" : "<Name>\(_name!)</Name>") }
	func phone() -> String { return (_phone == nil ? "" : "<Phone>\(_phone!)</Phone>") }
}

final class FreightShipmentDetail : CustomStringConvertible
{
	fileprivate let _fedExFreightAccountNumber: String?
	fileprivate let _fedExFreightBillingContactAndAddress: ContactAndAddress?
	fileprivate let _alternateBilling: Party?
	fileprivate let _role: FreightShipmentRoleType?
	fileprivate let _collectTermsType: FreightCollectTermsType?
	fileprivate let _declaredValuePerUnit: Money?
	fileprivate let _declaredValueUnits: String?
	fileprivate let _liabilityCoverageDetail: LiabilityCoverageDetail?
	fileprivate let _coupons: String?
	fileprivate let _totalHandlingUnits: UInt?
	fileprivate let _clientDiscountPercent: Decimal?
	fileprivate let _palletWeight: Weight?
	fileprivate let _shipmentDimensions: Dimensions?
	fileprivate let _comment: String?
	fileprivate let _specialServicePayments: FreightSpecialServicePayment?
	fileprivate let _hazardousMaterialsOfferor: String?
	fileprivate let _lineItems: [FreightShipmentLineItem]
	
	var description: String { return "\(fedExFreightAccountNumber())\(fedExFreightBillingContactAndAddress())\(alternateBilling())\(role())\(collectTermsType())\(declaredValuePerUnit())\(declaredValueUnits())\(liabilityCoverageDetail())\(coupons())\(totalHandlingUnits())\(clientDiscountPercent())\(palletWeight())\(shipmentDimensions())\(comment())\(specialServicePayments())\(hazardousMaterialsOfferor())\(lineItems())" }
	
	init(fedExFreightAccountNumber: String?, fedExFreightBillingContactAndAddress: ContactAndAddress?, alternateBilling: Party?, role: FreightShipmentRoleType?, collectTermsType: FreightCollectTermsType?, declaredValuePerUnit: Money?, declaredValueUnits: String?, liabilityCoverageDetail: LiabilityCoverageDetail?, coupons: String?, totalHandlingUnits: UInt?, clientDiscountPercent: Decimal?, palletWeight: Weight?, shipmentDimensions: Dimensions?, comment: String?, specialServicePayments: FreightSpecialServicePayment?, hazardousMaterialsOfferor: String?, lineItems: [FreightShipmentLineItem])
	{
		_fedExFreightAccountNumber = fedExFreightAccountNumber
		_fedExFreightBillingContactAndAddress = fedExFreightBillingContactAndAddress
		_alternateBilling = alternateBilling
		_role = role
		_collectTermsType = collectTermsType
		_declaredValuePerUnit = declaredValuePerUnit
		_declaredValueUnits = declaredValueUnits
		_liabilityCoverageDetail = liabilityCoverageDetail
		_coupons = coupons
		_totalHandlingUnits = totalHandlingUnits
		_clientDiscountPercent = clientDiscountPercent
		_palletWeight = palletWeight
		_shipmentDimensions = shipmentDimensions
		_comment = comment
		_specialServicePayments = specialServicePayments
		_hazardousMaterialsOfferor = hazardousMaterialsOfferor
		_lineItems = lineItems
	}
	
	func fedExFreightAccountNumber() -> String { return (_fedExFreightAccountNumber == nil ? "" : "<FedExFreightAccountNumber>\(_fedExFreightAccountNumber!)</FedExFreightAccountNumber>") }
	func fedExFreightBillingContactAndAddress() -> String { return (_fedExFreightBillingContactAndAddress == nil ? "" : "<FedExFreightBillingContactAndAddress>\(_fedExFreightBillingContactAndAddress!)</FedExFreightBillingContactAndAddress>") }
	func alternateBilling() -> String { return (_alternateBilling == nil ? "" : "<AlternateBilling>\(_alternateBilling!)</AlternateBilling>") }
	func role() -> String { return (_role == nil ? "" : "<Role>\(_role!)</Role>") }
	func collectTermsType() -> String { return (_collectTermsType == nil ? "" : "<CollectTermsType>\(_collectTermsType!)</CollectTermsType>") }
	func declaredValuePerUnit() -> String { return (_declaredValuePerUnit == nil ? "" : "<DeclaredValuePerUnit>\(_declaredValuePerUnit!)</DeclaredValuePerUnit>") }
	func declaredValueUnits() -> String { return (_declaredValueUnits == nil ? "" : "<DeclaredValueUnits>\(_declaredValueUnits!)</DeclaredValueUnits>") }
	func liabilityCoverageDetail() -> String { return (_liabilityCoverageDetail == nil ? "" : "<LiabilityCoverageDetail>\(_liabilityCoverageDetail!)</LiabilityCoverageDetail>") }
	func coupons() -> String { return (_coupons == nil ? "" : "<Coupons>\(_coupons!)</Coupons>") }
	func totalHandlingUnits() -> String { return (_totalHandlingUnits == nil ? "" : "<TotalHandlingUnits>\(_totalHandlingUnits!)</TotalHandlingUnits>") }
	func clientDiscountPercent() -> String { return (_clientDiscountPercent == nil ? "" : "<ClientDiscountPercent>\(_clientDiscountPercent!)</ClientDiscountPercent>") }
	func palletWeight() -> String { return (_palletWeight == nil ? "" : "<PalletWeight>\(_palletWeight!)</PalletWeight>") }
	func shipmentDimensions() -> String { return (_shipmentDimensions == nil ? "" : "<ShipmentDimensions>\(_shipmentDimensions!)</ShipmentDimensions>") }
	func comment() -> String { return (_comment == nil ? "" : "<Comment>\(_comment!)</Comment>") }
	func specialServicePayments() -> String { return (_specialServicePayments == nil ? "" : "<SpecialServicePayments>\(_specialServicePayments!)</SpecialServicePayments>") }
	func hazardousMaterialsOfferor() -> String { return (_hazardousMaterialsOfferor == nil ? "" : "<HazardousMaterialsOfferor>\(_hazardousMaterialsOfferor!)</HazardousMaterialsOfferor>") }
	func lineItems() -> String { return "\((_lineItems.map{ "<LineItems>\($0)</LineItems>" } as [String]).joined())" }
}

final class LiabilityCoverageDetail : CustomStringConvertible
{
	fileprivate let _coverageType: LiabilityCoverageType?
	fileprivate let _coverageAmount: Money?
	
	var description: String { return "\(coverageType())\(coverageAmount())" }
	
	init(coverageType: LiabilityCoverageType, coverageAmount: Money)
	{
		_coverageType = coverageType
		_coverageAmount = coverageAmount
	}
	
	func coverageType() -> String { return (_coverageType == nil ? "" : "<CoverageType>\(_coverageType!)</CoverageType>") }
	func coverageAmount() -> String { return (_coverageAmount == nil ? "" : "<CoverageAmount>\(_coverageAmount!)</CoverageAmount>") }
}

final class FreightSpecialServicePayment : CustomStringConvertible
{
	fileprivate let _specialService: ShipmentSpecialServiceType?
	fileprivate let _paymentType: FreightShipmentRoleType?
	
	var description: String { return "\(specialService())\(paymentType())" }
	
	init(specialService: ShipmentSpecialServiceType, paymentType: FreightShipmentRoleType)
	{
		_specialService = specialService
		_paymentType = paymentType
	}
	
	func specialService() -> String { return (_specialService == nil ? "" : "<SpecialService>\(_specialService!)</SpecialService>") }
	func paymentType() -> String { return (_paymentType == nil ? "" : "<PaymentType>\(_paymentType!)</PaymentType>") }
}

final class FreightShipmentLineItem : CustomStringConvertible
{
	let _freightClass: FreightClassType?
	let _packaging: PhysicalPackagingType?
	let _pieces: UInt?
	let _description: String?
	let _weight: Weight?
	let _dimensions: Dimensions?
	let _volume: Volume?
	
	var description: String { return "\(freightClass())\(packaging())\(pieces())\(description_())\(weight())\(dimensions())\(volume())" }
	
	init(freightClass: FreightClassType?, packaging: PhysicalPackagingType?, pieces: UInt?, description: String?, weight: Weight?, dimensions: Dimensions?, volume: Volume?)
	{
		_freightClass = freightClass
		_packaging = packaging
		_pieces = pieces
		_description = description
		_weight = weight
		_dimensions = dimensions
		_volume = volume
	}
	
	fileprivate func freightClass() -> String { return (_freightClass == nil ? "" : "<FreightClass>\(_freightClass!)</FreightClass>") }
	fileprivate func packaging() -> String { return (_packaging == nil ? "" : "<Packaging>\(_packaging!)</Packaging>") }
	fileprivate func pieces() -> String { return (_pieces == nil ? "" : "<Pieces>\(_pieces!)</Pieces>") }
	fileprivate func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	fileprivate func weight() -> String { return (_weight == nil ? "" : "<Weight>\(_weight!)</Weight>") }
	fileprivate func dimensions() -> String { return (_dimensions == nil ? "" : "<Dimensions>\(_dimensions!)</Dimensions>") }
	fileprivate func volume() -> String { return (_volume == nil ? "" : "<Volume>\(_volume!)</Volume>") }
}

final class Volume : CustomStringConvertible
{
	fileprivate let _units: VolumeUnits?
	fileprivate let _value: Float?
	
	var description: String { return "\(units())\(value())" }
	
	init(units: VolumeUnits?, value: Float?)
	{
		_units = units
		_value = value
	}
	
	func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
	func value() -> String { return (_value == nil ? "" : "<Value>\(_value!)</Value>") }
}

final class VariableHandlingChargeDetail : CustomStringConvertible
{
	fileprivate let _fixedValue: Money?
	fileprivate let _percentValue: Decimal?
	fileprivate let _rateElementBasis: RateElementBasisType?
	fileprivate let _rateTypeBasis: RateTypeBasisType?
	
	var description: String { return "\(fixedValue())\(percentValue())\(rateElementBasis())\(rateTypeBasis())" }
	
	init(fixedValue: Money, percentValue: Decimal, rateElementBasis: RateElementBasisType, rateTypeBasis: RateTypeBasisType)
	{
		_fixedValue = fixedValue
		_percentValue = percentValue
		_rateElementBasis = rateElementBasis
		_rateTypeBasis = rateTypeBasis
	}
	
	func fixedValue() -> String { return (_fixedValue == nil ? "" : "<FixedValue>\(_fixedValue!)</FixedValue>") }
	func percentValue() -> String { return (_percentValue == nil ? "" : "<PercentValue>\(_percentValue!)</PercentValue>") }
	func rateElementBasis() -> String { return (_rateElementBasis == nil ? "" : "<RateElementBasis>\(_rateElementBasis!)</RateElementBasis>") }
	func rateTypeBasis() -> String { return (_rateTypeBasis == nil ? "" : "<RateTypeBasis>\(_rateTypeBasis!)</RateTypeBasis>") }
}

final class CustomsClearanceDetail : CustomStringConvertible
{
	fileprivate let _brokers: BrokerDetail?
	fileprivate let _clearanceBrokerage: ClearanceBrokerageType?
	fileprivate let _customsOptions: CustomsOptionDetail?
	fileprivate let _importerOfRecord: Party?
	fileprivate let _recipientCustomsId: RecipientCustomsId?
	fileprivate let _dutiesPayment: Payment?
	fileprivate let _documentContent: InternationalDocumentContentType?
	fileprivate let _customsValue: Money?
	fileprivate let _freightOnValue: FreightOnValueType?
	fileprivate let _insuranceCharges: Money?
	fileprivate let _partiesToTransactionAreRelated: Bool?
	fileprivate let _commercialInvoice: CommercialInvoice?
	fileprivate let _commodities: Commodity?
	fileprivate let _exportDetail: ExportDetail?
	fileprivate let _regulatoryControls: RegulatoryControlType?
	
	var description: String { return "\(brokers())\(clearanceBrokerage())\(customsOptions())\(importerOfRecord())\(recipientCustomsId())\(dutiesPayment())\(documentContent())\(customsValue())\(freightOnValue())\(insuranceCharges())\(partiesToTransactionAreRelated())\(commercialInvoice())\(commodities())\(exportDetail())\(regulatoryControls())" }
	
	init(brokers: BrokerDetail, clearanceBrokerage: ClearanceBrokerageType, customsOptions: CustomsOptionDetail, importerOfRecord: Party, recipientCustomsId: RecipientCustomsId, dutiesPayment: Payment, documentContent: InternationalDocumentContentType, customsValue: Money, freightOnValue: FreightOnValueType, insuranceCharges: Money, partiesToTransactionAreRelated: Bool, commercialInvoice: CommercialInvoice, commodities: Commodity, exportDetail: ExportDetail, regulatoryControls: RegulatoryControlType)
	{
		_brokers = brokers
		_clearanceBrokerage = clearanceBrokerage
		_customsOptions = customsOptions
		_importerOfRecord = importerOfRecord
		_recipientCustomsId = recipientCustomsId
		_dutiesPayment = dutiesPayment
		_documentContent = documentContent
		_customsValue = customsValue
		_freightOnValue = freightOnValue
		_insuranceCharges = insuranceCharges
		_partiesToTransactionAreRelated = partiesToTransactionAreRelated
		_commercialInvoice = commercialInvoice
		_commodities = commodities
		_exportDetail = exportDetail
		_regulatoryControls = regulatoryControls
	}
	
	func brokers() -> String { return (_brokers == nil ? "" : "<Brokers>\(_brokers!)</Brokers>") }
	func clearanceBrokerage() -> String { return (_clearanceBrokerage == nil ? "" : "<ClearanceBrokerage>\(_clearanceBrokerage!)</ClearanceBrokerage>") }
	func customsOptions() -> String { return (_customsOptions == nil ? "" : "<CustomsOptions>\(_customsOptions!)</CustomsOptions>") }
	func importerOfRecord() -> String { return (_importerOfRecord == nil ? "" : "<ImporterOfRecord>\(_importerOfRecord!)</ImporterOfRecord>") }
	func recipientCustomsId() -> String { return (_recipientCustomsId == nil ? "" : "<RecipientCustomsId>\(_recipientCustomsId!)</RecipientCustomsId>") }
	func dutiesPayment() -> String { return (_dutiesPayment == nil ? "" : "<DutiesPayment>\(_dutiesPayment!)</DutiesPayment>") }
	func documentContent() -> String { return (_documentContent == nil ? "" : "<DocumentContent>\(_documentContent!)</DocumentContent>") }
	func customsValue() -> String { return (_customsValue == nil ? "" : "<CustomsValue>\(_customsValue!)</CustomsValue>") }
	func freightOnValue() -> String { return (_freightOnValue == nil ? "" : "<FreightOnValue>\(_freightOnValue!)</FreightOnValue>") }
	func insuranceCharges() -> String { return (_insuranceCharges == nil ? "" : "<InsuranceCharges>\(_insuranceCharges!)</InsuranceCharges>") }
	func partiesToTransactionAreRelated() -> String { return (_partiesToTransactionAreRelated == nil ? "" : "<PartiesToTransactionAreRelated>\(_partiesToTransactionAreRelated!)</PartiesToTransactionAreRelated>") }
	func commercialInvoice() -> String { return (_commercialInvoice == nil ? "" : "<CommercialInvoice>\(_commercialInvoice!)</CommercialInvoice>") }
	func commodities() -> String { return (_commodities == nil ? "" : "<Commodities>\(_commodities!)</Commodities>") }
	func exportDetail() -> String { return (_exportDetail == nil ? "" : "<ExportDetail>\(_exportDetail!)</ExportDetail>") }
	func regulatoryControls() -> String { return (_regulatoryControls == nil ? "" : "<RegulatoryControls>\(_regulatoryControls!)</RegulatoryControls>") }
}

final class BrokerDetail : CustomStringConvertible
{
	fileprivate let _type: BrokerType?
	fileprivate let _broker: Party?
	
	var description: String { return "\(type())\(broker())" }
	
	init(type: BrokerType, broker: Party)
	{
		_type = type
		_broker = broker
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func broker() -> String { return (_broker == nil ? "" : "<Broker>\(_broker!)</Broker>") }
}

final class CustomsOptionDetail : CustomStringConvertible
{
	fileprivate let _type: CustomsOptionType?
	fileprivate let _description: String?
	
	var description: String { return "\(type())\(description_())" }
	
	init(type: CustomsOptionType, description: String)
	{
		_type = type
		_description = description
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
}

final class RecipientCustomsId : CustomStringConvertible
{
	fileprivate let _type: RecipientCustomsIdType?
	fileprivate let _value: String?
	
	var description: String { return "\(type())\(value())" }
	
	init(type: RecipientCustomsIdType, value: String)
	{
		_type = type
		_value = value
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func value() -> String { return (_value == nil ? "" : "<Value>\(_value!)</Value>") }
}

final class CommercialInvoice : CustomStringConvertible
{
	fileprivate let _comments: String?
	fileprivate let _freightCharge: Money?
	fileprivate let _taxesOrMiscellaneousCharge: Money?
	fileprivate let _taxesOrMiscellaneousChargeType: TaxesOrMiscellaneousChargeType?
	fileprivate let _packingCosts: Money?
	fileprivate let _handlingCosts: Money?
	fileprivate let _specialInstructions: String?
	fileprivate let _declarationStatement: String?
	fileprivate let _paymentTerms: String?
	fileprivate let _purpose: PurposeOfShipmentType?
	fileprivate let _originatorName: String?
	fileprivate let _termsOfSale: String?
	
	var description: String { return "\(comments())\(freightCharge())\(taxesOrMiscellaneousCharge())\(taxesOrMiscellaneousChargeType())\(packingCosts())\(handlingCosts())\(specialInstructions())\(declarationStatement())\(paymentTerms())\(purpose())\(originatorName())\(termsOfSale())" }
	
	init(comments: String, freightCharge: Money, taxesOrMiscellaneousCharge: Money, taxesOrMiscellaneousChargeType: TaxesOrMiscellaneousChargeType, packingCosts: Money, handlingCosts: Money, specialInstructions: String, declarationStatement: String, paymentTerms: String, purpose: PurposeOfShipmentType, originatorName: String, termsOfSale: String)
	{
		_comments = comments
		_freightCharge = freightCharge
		_taxesOrMiscellaneousCharge = taxesOrMiscellaneousCharge
		_taxesOrMiscellaneousChargeType = taxesOrMiscellaneousChargeType
		_packingCosts = packingCosts
		_handlingCosts = handlingCosts
		_specialInstructions = specialInstructions
		_declarationStatement = declarationStatement
		_paymentTerms = paymentTerms
		_purpose = purpose
		_originatorName = originatorName
		_termsOfSale = termsOfSale
	}
	
	func comments() -> String { return (_comments == nil ? "" : "<Comments>\(_comments!)</Comments>") }
	func freightCharge() -> String { return (_freightCharge == nil ? "" : "<FreightCharge>\(_freightCharge!)</FreightCharge>") }
	func taxesOrMiscellaneousCharge() -> String { return (_taxesOrMiscellaneousCharge == nil ? "" : "<TaxesOrMiscellaneousCharge>\(_taxesOrMiscellaneousCharge!)</TaxesOrMiscellaneousCharge>") }
	func taxesOrMiscellaneousChargeType() -> String { return (_taxesOrMiscellaneousChargeType == nil ? "" : "<TaxesOrMiscellaneousChargeType>\(_taxesOrMiscellaneousChargeType!)</TaxesOrMiscellaneousChargeType>") }
	func packingCosts() -> String { return (_packingCosts == nil ? "" : "<PackingCosts>\(_packingCosts!)</PackingCosts>") }
	func handlingCosts() -> String { return (_handlingCosts == nil ? "" : "<HandlingCosts>\(_handlingCosts!)</HandlingCosts>") }
	func specialInstructions() -> String { return (_specialInstructions == nil ? "" : "<SpecialInstructions>\(_specialInstructions!)</SpecialInstructions>") }
	func declarationStatement() -> String { return (_declarationStatement == nil ? "" : "<DeclarationStatement>\(_declarationStatement!)</DeclarationStatement>") }
	func paymentTerms() -> String { return (_paymentTerms == nil ? "" : "<PaymentTerms>\(_paymentTerms!)</PaymentTerms>") }
	func purpose() -> String { return (_purpose == nil ? "" : "<Purpose>\(_purpose!)</Purpose>") }
	func originatorName() -> String { return (_originatorName == nil ? "" : "<OriginatorName>\(_originatorName!)</OriginatorName>") }
	func termsOfSale() -> String { return (_termsOfSale == nil ? "" : "<TermsOfSale>\(_termsOfSale!)</TermsOfSale>") }
}

final class Commodity : CustomStringConvertible
{
	fileprivate let _name: String?
	fileprivate let _numberOfPieces: UInt?
	fileprivate let _description: String?
	fileprivate let _purpose: CommodityPurposeType?
	fileprivate let _countryOfManufacture: String?
	fileprivate let _harmonizedCode: String?
	fileprivate let _weight: Weight?
	fileprivate let _quantity: Decimal?
	fileprivate let _quantityUnits: String?
	fileprivate let _additionalMeasures: Measure?
	fileprivate let _unitPrice: Money?
	fileprivate let _customsValue: Money?
	fileprivate let _exciseConditions: EdtExciseCondition?
	fileprivate let _exportLicenseNumber: String?
	fileprivate let _exportLicenseExpirationDate: Date?
	fileprivate let _cIMarksAndNumbers: String?
	fileprivate let _partNumber: String?
	fileprivate let _naftaDetail: NaftaCommodityDetail?
	
	var description: String { return "\(name())\(numberOfPieces())\(description_())\(purpose())\(countryOfManufacture())\(harmonizedCode())\(weight())\(quantity())\(quantityUnits())\(additionalMeasures())\(unitPrice())\(customsValue())\(exciseConditions())\(exportLicenseNumber())\(exportLicenseExpirationDate())\(cIMarksAndNumbers())\(partNumber())\(naftaDetail())" }
	
	init(name: String, numberOfPieces: UInt, description: String, purpose: CommodityPurposeType, countryOfManufacture: String, harmonizedCode: String, weight: Weight, quantity: Decimal, quantityUnits: String, additionalMeasures: Measure, unitPrice: Money, customsValue: Money, exciseConditions: EdtExciseCondition, exportLicenseNumber: String, exportLicenseExpirationDate: Date, cIMarksAndNumbers: String, partNumber: String, naftaDetail: NaftaCommodityDetail)
	{
		_name = name
		_numberOfPieces = numberOfPieces
		_description = description
		_purpose = purpose
		_countryOfManufacture = countryOfManufacture
		_harmonizedCode = harmonizedCode
		_weight = weight
		_quantity = quantity
		_quantityUnits = quantityUnits
		_additionalMeasures = additionalMeasures
		_unitPrice = unitPrice
		_customsValue = customsValue
		_exciseConditions = exciseConditions
		_exportLicenseNumber = exportLicenseNumber
		_exportLicenseExpirationDate = exportLicenseExpirationDate
		_cIMarksAndNumbers = cIMarksAndNumbers
		_partNumber = partNumber
		_naftaDetail = naftaDetail
	}
	
	func name() -> String { return (_name == nil ? "" : "<Name>\(_name!)</Name>") }
	func numberOfPieces() -> String { return (_numberOfPieces == nil ? "" : "<NumberOfPieces>\(_numberOfPieces!)</NumberOfPieces>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func purpose() -> String { return (_purpose == nil ? "" : "<Purpose>\(_purpose!)</Purpose>") }
	func countryOfManufacture() -> String { return (_countryOfManufacture == nil ? "" : "<CountryOfManufacture>\(_countryOfManufacture!)</CountryOfManufacture>") }
	func harmonizedCode() -> String { return (_harmonizedCode == nil ? "" : "<HarmonizedCode>\(_harmonizedCode!)</HarmonizedCode>") }
	func weight() -> String { return (_weight == nil ? "" : "<Weight>\(_weight!)</Weight>") }
	func quantity() -> String { return (_quantity == nil ? "" : "<Quantity>\(_quantity!)</Quantity>") }
	func quantityUnits() -> String { return (_quantityUnits == nil ? "" : "<QuantityUnits>\(_quantityUnits!)</QuantityUnits>") }
	func additionalMeasures() -> String { return (_additionalMeasures == nil ? "" : "<AdditionalMeasures>\(_additionalMeasures!)</AdditionalMeasures>") }
	func unitPrice() -> String { return (_unitPrice == nil ? "" : "<UnitPrice>\(_unitPrice!)</UnitPrice>") }
	func customsValue() -> String { return (_customsValue == nil ? "" : "<CustomsValue>\(_customsValue!)</CustomsValue>") }
	func exciseConditions() -> String { return (_exciseConditions == nil ? "" : "<ExciseConditions>\(_exciseConditions!)</ExciseConditions>") }
	func exportLicenseNumber() -> String { return (_exportLicenseNumber == nil ? "" : "<ExportLicenseNumber>\(_exportLicenseNumber!)</ExportLicenseNumber>") }
	func exportLicenseExpirationDate() -> String { return (_exportLicenseExpirationDate == nil ? "" : "<ExportLicenseExpirationDate>\(_exportLicenseExpirationDate!)</ExportLicenseExpirationDate>") }
	func cIMarksAndNumbers() -> String { return (_cIMarksAndNumbers == nil ? "" : "<CIMarksAndNumbers>\(_cIMarksAndNumbers!)</CIMarksAndNumbers>") }
	func partNumber() -> String { return (_partNumber == nil ? "" : "<PartNumber>\(_partNumber!)</PartNumber>") }
	func naftaDetail() -> String { return (_naftaDetail == nil ? "" : "<NaftaDetail>\(_naftaDetail!)</NaftaDetail>") }
}

struct Measure : CustomStringConvertible
{
	fileprivate let _quantity: Decimal?
	fileprivate let _units: String?
	
	var description: String { return "\(quantity())\(units())" }
	
	init(quantity: Decimal, units: String)
	{
		_quantity = quantity
		_units = units
	}
	
	func quantity() -> String { return (_quantity == nil ? "" : "<Quantity>\(_quantity!)</Quantity>") }
	func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
}

struct EdtExciseCondition : CustomStringConvertible
{
	fileprivate let _category: String?
	fileprivate let _value: String?
	
	var description: String { return "\(category())\(value())" }
	
	init(category: String, value: String)
	{
		_category = category
		_value = value
	}
	
	func category() -> String { return (_category == nil ? "" : "<Category>\(_category!)</Category>") }
	func value() -> String { return (_value == nil ? "" : "<Value>\(_value!)</Value>") }
}

final class NaftaCommodityDetail : CustomStringConvertible
{
	fileprivate let _referenceCriterion: NaftaPreferenceCriterionCode?
	fileprivate let _producerDetermination: NaftaProducerDeterminationCode?
	fileprivate let _producerId: String?
	fileprivate let _netCostMethod: NaftaNetCostMethodCode?
	fileprivate let _netCostDateRange: DateRange?
	
	var description: String { return "\(referenceCriterion())\(producerDetermination())\(producerId())\(netCostMethod())\(netCostDateRange())" }
	
	init(referenceCriterion: NaftaPreferenceCriterionCode, producerDetermination: NaftaProducerDeterminationCode, producerId: String, netCostMethod: NaftaNetCostMethodCode, netCostDateRange: DateRange)
	{
		_referenceCriterion = referenceCriterion
		_producerDetermination = producerDetermination
		_producerId = producerId
		_netCostMethod = netCostMethod
		_netCostDateRange = netCostDateRange
	}
	
	func referenceCriterion() -> String { return (_referenceCriterion == nil ? "" : "<ReferenceCriterion>\(_referenceCriterion!)</ReferenceCriterion>") }
	func producerDetermination() -> String { return (_producerDetermination == nil ? "" : "<ProducerDetermination>\(_producerDetermination!)</ProducerDetermination>") }
	func producerId() -> String { return (_producerId == nil ? "" : "<ProducerId>\(_producerId!)</ProducerId>") }
	func netCostMethod() -> String { return (_netCostMethod == nil ? "" : "<NetCostMethod>\(_netCostMethod!)</NetCostMethod>") }
	func netCostDateRange() -> String { return (_netCostDateRange == nil ? "" : "<NetCostDateRange>\(_netCostDateRange!)</NetCostDateRange>") }
}

final class ExportDetail : CustomStringConvertible
{
	fileprivate let _b13AFilingOption: B13AFilingOptionType?
	fileprivate let _exportComplianceStatement: String?
	fileprivate let _permitNumber: String?
	fileprivate let _destinationControlDetail: DestinationControlDetail?
	
	var description: String { return "\(b13AFilingOption())\(exportComplianceStatement())\(permitNumber())\(destinationControlDetail())" }
	
	init(b13AFilingOption: B13AFilingOptionType, exportComplianceStatement: String, permitNumber: String, destinationControlDetail: DestinationControlDetail)
	{
		_b13AFilingOption = b13AFilingOption
		_exportComplianceStatement = exportComplianceStatement
		_permitNumber = permitNumber
		_destinationControlDetail = destinationControlDetail
	}
	
	func b13AFilingOption() -> String { return (_b13AFilingOption == nil ? "" : "<B13AFilingOption>\(_b13AFilingOption!)</B13AFilingOption>") }
	func exportComplianceStatement() -> String { return (_exportComplianceStatement == nil ? "" : "<ExportComplianceStatement>\(_exportComplianceStatement!)</ExportComplianceStatement>") }
	func permitNumber() -> String { return (_permitNumber == nil ? "" : "<PermitNumber>\(_permitNumber!)</PermitNumber>") }
	func destinationControlDetail() -> String { return (_destinationControlDetail == nil ? "" : "<DestinationControlDetail>\(_destinationControlDetail!)</DestinationControlDetail>") }
}

final class DestinationControlDetail : CustomStringConvertible
{
	fileprivate let _statementTypes: DestinationControlStatementType?
	fileprivate let _destinationCountries: String?
	fileprivate let _endUser: String?
	
	var description: String { return "\(statementTypes())\(destinationCountries())\(endUser())" }
	
	init(statementTypes: DestinationControlStatementType, destinationCountries: String, endUser: String)
	{
		_statementTypes = statementTypes
		_destinationCountries = destinationCountries
		_endUser = endUser
	}
	
	func statementTypes() -> String { return (_statementTypes == nil ? "" : "<StatementTypes>\(_statementTypes!)</StatementTypes>") }
	func destinationCountries() -> String { return (_destinationCountries == nil ? "" : "<DestinationCountries>\(_destinationCountries!)</DestinationCountries>") }
	func endUser() -> String { return (_endUser == nil ? "" : "<EndUser>\(_endUser!)</EndUser>") }
}

final class PickupDetail : CustomStringConvertible
{
	fileprivate let _readyDateTime: Date?
	fileprivate let _latestPickupDateTime: Date?
	fileprivate let _courierInstructions: String?
	fileprivate let _requestType: PickupRequestType?
	fileprivate let _requestSource: PickupRequestSourceType?
	
	var description: String { return "\(readyDateTime())\(latestPickupDateTime())\(courierInstructions())\(requestType())\(requestSource())" }
	
	init(readyDateTime: Date, latestPickupDateTime: Date, courierInstructions: String, requestType: PickupRequestType, requestSource: PickupRequestSourceType)
	{
		_readyDateTime = readyDateTime
		_latestPickupDateTime = latestPickupDateTime
		_courierInstructions = courierInstructions
		_requestType = requestType
		_requestSource = requestSource
	}
	
	func readyDateTime() -> String { return (_readyDateTime == nil ? "" : "<ReadyDateTime>\(_readyDateTime!)</ReadyDateTime>") }
	func latestPickupDateTime() -> String { return (_latestPickupDateTime == nil ? "" : "<LatestPickupDateTime>\(_latestPickupDateTime!)</LatestPickupDateTime>") }
	func courierInstructions() -> String { return (_courierInstructions == nil ? "" : "<CourierInstructions>\(_courierInstructions!)</CourierInstructions>") }
	func requestType() -> String { return (_requestType == nil ? "" : "<RequestType>\(_requestType!)</RequestType>") }
	func requestSource() -> String { return (_requestSource == nil ? "" : "<RequestSource>\(_requestSource!)</RequestSource>") }
}

final class SmartPostShipmentDetail : CustomStringConvertible
{
	fileprivate let _processingOptionsRequested: SmartPostShipmentProcessingOptionsRequested?
	fileprivate let _indicia: SmartPostIndiciaType?
	fileprivate let _ancillaryEndorsement: SmartPostAncillaryEndorsementType?
	fileprivate let _hubId: String?
	fileprivate let _customerManifestId: String?
	
	var description: String { return "\(processingOptionsRequested())\(indicia())\(ancillaryEndorsement())\(hubId())\(customerManifestId())" }
	
	init(processingOptionsRequested: SmartPostShipmentProcessingOptionsRequested, indicia: SmartPostIndiciaType, ancillaryEndorsement: SmartPostAncillaryEndorsementType, hubId: String, customerManifestId: String)
	{
		_processingOptionsRequested = processingOptionsRequested
		_indicia = indicia
		_ancillaryEndorsement = ancillaryEndorsement
		_hubId = hubId
		_customerManifestId = customerManifestId
	}
	
	func processingOptionsRequested() -> String { return (_processingOptionsRequested == nil ? "" : "<ProcessingOptionsRequested>\(_processingOptionsRequested!)</ProcessingOptionsRequested>") }
	func indicia() -> String { return (_indicia == nil ? "" : "<Indicia>\(_indicia!)</Indicia>") }
	func ancillaryEndorsement() -> String { return (_ancillaryEndorsement == nil ? "" : "<AncillaryEndorsement>\(_ancillaryEndorsement!)</AncillaryEndorsement>") }
	func hubId() -> String { return (_hubId == nil ? "" : "<HubId>\(_hubId!)</HubId>") }
	func customerManifestId() -> String { return (_customerManifestId == nil ? "" : "<CustomerManifestId>\(_customerManifestId!)</CustomerManifestId>") }
}

final class SmartPostShipmentProcessingOptionsRequested : CustomStringConvertible
{
	fileprivate let _options: SmartPostShipmentProcessingOptionType?
	
	var description: String { return "\(options())" }
	
	init(options: SmartPostShipmentProcessingOptionType)
	{
		_options = options
	}
	
	func options() -> String { return (_options == nil ? "" : "<Options>\(_options!)</Options>") }
}

final class LabelSpecification : CustomStringConvertible
{
	fileprivate let _labelFormatType: LabelFormatType?
	fileprivate let _imageType: ShippingDocumentImageType?
	fileprivate let _labelStockType: LabelStockType?
	fileprivate let _labelPrintingOrientation: LabelPrintingOrientationType?
	fileprivate let _labelRotation: LabelRotationType?
	fileprivate let _labelOrder: LabelOrderType?
	fileprivate let _printedLabelOrigin: ContactAndAddress?
	fileprivate let _customerSpecifiedDetail: CustomerSpecifiedLabelDetail?
	
	var description: String { return "\(labelFormatType())\(imageType())\(labelStockType())\(labelPrintingOrientation())\(labelRotation())\(labelOrder())\(printedLabelOrigin())\(customerSpecifiedDetail())" }
	
	init(labelFormatType: LabelFormatType, imageType: ShippingDocumentImageType, labelStockType: LabelStockType, labelPrintingOrientation: LabelPrintingOrientationType, labelRotation: LabelRotationType, labelOrder: LabelOrderType, printedLabelOrigin: ContactAndAddress, customerSpecifiedDetail: CustomerSpecifiedLabelDetail)
	{
		_labelFormatType = labelFormatType
		_imageType = imageType
		_labelStockType = labelStockType
		_labelPrintingOrientation = labelPrintingOrientation
		_labelRotation = labelRotation
		_labelOrder = labelOrder
		_printedLabelOrigin = printedLabelOrigin
		_customerSpecifiedDetail = customerSpecifiedDetail
	}
	
	func labelFormatType() -> String { return (_labelFormatType == nil ? "" : "<LabelFormatType>\(_labelFormatType!)</LabelFormatType>") }
	func imageType() -> String { return (_imageType == nil ? "" : "<ImageType>\(_imageType!)</ImageType>") }
	func labelStockType() -> String { return (_labelStockType == nil ? "" : "<LabelStockType>\(_labelStockType!)</LabelStockType>") }
	func labelPrintingOrientation() -> String { return (_labelPrintingOrientation == nil ? "" : "<LabelPrintingOrientation>\(_labelPrintingOrientation!)</LabelPrintingOrientation>") }
	func labelRotation() -> String { return (_labelRotation == nil ? "" : "<LabelRotation>\(_labelRotation!)</LabelRotation>") }
	func labelOrder() -> String { return (_labelOrder == nil ? "" : "<LabelOrder>\(_labelOrder!)</LabelOrder>") }
	func printedLabelOrigin() -> String { return (_printedLabelOrigin == nil ? "" : "<PrintedLabelOrigin>\(_printedLabelOrigin!)</PrintedLabelOrigin>") }
	func customerSpecifiedDetail() -> String { return (_customerSpecifiedDetail == nil ? "" : "<CustomerSpecifiedDetail>\(_customerSpecifiedDetail!)</CustomerSpecifiedDetail>") }
}

final class ShippingDocumentSpecification : CustomStringConvertible
{
	fileprivate let _shippingDocumentTypes: RequestedShippingDocumentType?
	fileprivate let _certificateOfOrigin: CertificateOfOriginDetail?
	fileprivate let _commercialInvoiceDetail: CommercialInvoiceDetail?
	fileprivate let _customPackageDocumentDetail: CustomDocumentDetail?
	fileprivate let _customShipmentDocumentDetail: CustomDocumentDetail?
	fileprivate let _exportDeclarationDetail: ExportDeclarationDetail?
	fileprivate let _generalAgencyAgreementDetail: GeneralAgencyAgreementDetail?
	fileprivate let _naftaCertificateOfOriginDetail: NaftaCertificateOfOriginDetail?
	fileprivate let _op900Detail: Op900Detail?
	fileprivate let _dangerousGoodsShippersDeclarationDetail: DangerousGoodsShippersDeclarationDetail?
	fileprivate let _freightAddressLabelDetail: FreightAddressLabelDetail?
	fileprivate let _returnInstructionsDetail: ReturnInstructionsDetail?
	
	var description: String { return "\(shippingDocumentTypes())\(certificateOfOrigin())\(commercialInvoiceDetail())\(customPackageDocumentDetail())\(customShipmentDocumentDetail())\(exportDeclarationDetail())\(generalAgencyAgreementDetail())\(naftaCertificateOfOriginDetail())\(op900Detail())\(dangerousGoodsShippersDeclarationDetail())\(freightAddressLabelDetail())\(returnInstructionsDetail())" }
	
	init(shippingDocumentTypes: RequestedShippingDocumentType, certificateOfOrigin: CertificateOfOriginDetail, commercialInvoiceDetail: CommercialInvoiceDetail, customPackageDocumentDetail: CustomDocumentDetail, customShipmentDocumentDetail: CustomDocumentDetail, exportDeclarationDetail: ExportDeclarationDetail, generalAgencyAgreementDetail: GeneralAgencyAgreementDetail, naftaCertificateOfOriginDetail: NaftaCertificateOfOriginDetail, op900Detail: Op900Detail, dangerousGoodsShippersDeclarationDetail: DangerousGoodsShippersDeclarationDetail, freightAddressLabelDetail: FreightAddressLabelDetail, returnInstructionsDetail: ReturnInstructionsDetail)
	{
		_shippingDocumentTypes = shippingDocumentTypes
		_certificateOfOrigin = certificateOfOrigin
		_commercialInvoiceDetail = commercialInvoiceDetail
		_customPackageDocumentDetail = customPackageDocumentDetail
		_customShipmentDocumentDetail = customShipmentDocumentDetail
		_exportDeclarationDetail = exportDeclarationDetail
		_generalAgencyAgreementDetail = generalAgencyAgreementDetail
		_naftaCertificateOfOriginDetail = naftaCertificateOfOriginDetail
		_op900Detail = op900Detail
		_dangerousGoodsShippersDeclarationDetail = dangerousGoodsShippersDeclarationDetail
		_freightAddressLabelDetail = freightAddressLabelDetail
		_returnInstructionsDetail = returnInstructionsDetail
	}
	
	func shippingDocumentTypes() -> String { return (_shippingDocumentTypes == nil ? "" : "<ShippingDocumentTypes>\(_shippingDocumentTypes!)</ShippingDocumentTypes>") }
	func certificateOfOrigin() -> String { return (_certificateOfOrigin == nil ? "" : "<CertificateOfOrigin>\(_certificateOfOrigin!)</CertificateOfOrigin>") }
	func commercialInvoiceDetail() -> String { return (_commercialInvoiceDetail == nil ? "" : "<CommercialInvoiceDetail>\(_commercialInvoiceDetail!)</CommercialInvoiceDetail>") }
	func customPackageDocumentDetail() -> String { return (_customPackageDocumentDetail == nil ? "" : "<CustomPackageDocumentDetail>\(_customPackageDocumentDetail!)</CustomPackageDocumentDetail>") }
	func customShipmentDocumentDetail() -> String { return (_customShipmentDocumentDetail == nil ? "" : "<CustomShipmentDocumentDetail>\(_customShipmentDocumentDetail!)</CustomShipmentDocumentDetail>") }
	func exportDeclarationDetail() -> String { return (_exportDeclarationDetail == nil ? "" : "<ExportDeclarationDetail>\(_exportDeclarationDetail!)</ExportDeclarationDetail>") }
	func generalAgencyAgreementDetail() -> String { return (_generalAgencyAgreementDetail == nil ? "" : "<GeneralAgencyAgreementDetail>\(_generalAgencyAgreementDetail!)</GeneralAgencyAgreementDetail>") }
	func naftaCertificateOfOriginDetail() -> String { return (_naftaCertificateOfOriginDetail == nil ? "" : "<NaftaCertificateOfOriginDetail>\(_naftaCertificateOfOriginDetail!)</NaftaCertificateOfOriginDetail>") }
	func op900Detail() -> String { return (_op900Detail == nil ? "" : "<Op900Detail>\(_op900Detail!)</Op900Detail>") }
	func dangerousGoodsShippersDeclarationDetail() -> String { return (_dangerousGoodsShippersDeclarationDetail == nil ? "" : "<DangerousGoodsShippersDeclarationDetail>\(_dangerousGoodsShippersDeclarationDetail!)</DangerousGoodsShippersDeclarationDetail>") }
	func freightAddressLabelDetail() -> String { return (_freightAddressLabelDetail == nil ? "" : "<FreightAddressLabelDetail>\(_freightAddressLabelDetail!)</FreightAddressLabelDetail>") }
	func returnInstructionsDetail() -> String { return (_returnInstructionsDetail == nil ? "" : "<ReturnInstructionsDetail>\(_returnInstructionsDetail!)</ReturnInstructionsDetail>") }
}

final class CertificateOfOriginDetail : CustomStringConvertible
{
	fileprivate let _documentFormat: ShippingDocumentFormat?
	fileprivate let _customerImageUsages: CustomerImageUsage?
	
	var description: String { return "\(documentFormat())\(customerImageUsages())" }
	
	init(documentFormat: ShippingDocumentFormat, customerImageUsages: CustomerImageUsage)
	{
		_documentFormat = documentFormat
		_customerImageUsages = customerImageUsages
	}
	
	func documentFormat() -> String { return (_documentFormat == nil ? "" : "<DocumentFormat>\(_documentFormat!)</DocumentFormat>") }
	func customerImageUsages() -> String { return (_customerImageUsages == nil ? "" : "<CustomerImageUsages>\(_customerImageUsages!)</CustomerImageUsages>") }
}

final class ShippingDocumentFormat : CustomStringConvertible
{
	fileprivate let _dispositions: ShippingDocumentDispositionDetail?
	fileprivate let _topOfPageOffset: LinearMeasure?
	fileprivate let _imageType: ShippingDocumentImageType?
	fileprivate let _stockType: ShippingDocumentStockType?
	fileprivate let _provideInstructions: Bool?
	fileprivate let _optionsRequested: DocumentFormatOptionsRequested?
	fileprivate let _localization: Localization?
	
	var description: String { return "\(dispositions())\(topOfPageOffset())\(imageType())\(stockType())\(provideInstructions())\(optionsRequested())\(localization())" }
	
	init(dispositions: ShippingDocumentDispositionDetail, topOfPageOffset: LinearMeasure, imageType: ShippingDocumentImageType, stockType: ShippingDocumentStockType, provideInstructions: Bool, optionsRequested: DocumentFormatOptionsRequested, localization: Localization)
	{
		_dispositions = dispositions
		_topOfPageOffset = topOfPageOffset
		_imageType = imageType
		_stockType = stockType
		_provideInstructions = provideInstructions
		_optionsRequested = optionsRequested
		_localization = localization
	}
	
	func dispositions() -> String { return (_dispositions == nil ? "" : "<Dispositions>\(_dispositions!)</Dispositions>") }
	func topOfPageOffset() -> String { return (_topOfPageOffset == nil ? "" : "<TopOfPageOffset>\(_topOfPageOffset!)</TopOfPageOffset>") }
	func imageType() -> String { return (_imageType == nil ? "" : "<ImageType>\(_imageType!)</ImageType>") }
	func stockType() -> String { return (_stockType == nil ? "" : "<StockType>\(_stockType!)</StockType>") }
	func provideInstructions() -> String { return (_provideInstructions == nil ? "" : "<ProvideInstructions>\(_provideInstructions!)</ProvideInstructions>") }
	func optionsRequested() -> String { return (_optionsRequested == nil ? "" : "<OptionsRequested>\(_optionsRequested!)</OptionsRequested>") }
	func localization() -> String { return (_localization == nil ? "" : "<Localization>\(_localization!)</Localization>") }
}

final class ShippingDocumentDispositionDetail : CustomStringConvertible
{
	fileprivate let _dispositionType: ShippingDocumentDispositionType?
	fileprivate let _grouping: ShippingDocumentGroupingType?
	fileprivate let _eMailDetail: ShippingDocumentEMailDetail?
	fileprivate let _printDetail: ShippingDocumentPrintDetail?
	
	var description: String { return "\(dispositionType())\(grouping())\(eMailDetail())\(printDetail())" }
	
	init(dispositionType: ShippingDocumentDispositionType, grouping: ShippingDocumentGroupingType, eMailDetail: ShippingDocumentEMailDetail, printDetail: ShippingDocumentPrintDetail)
	{
		_dispositionType = dispositionType
		_grouping = grouping
		_eMailDetail = eMailDetail
		_printDetail = printDetail
	}
	
	func dispositionType() -> String { return (_dispositionType == nil ? "" : "<DispositionType>\(_dispositionType!)</DispositionType>") }
	func grouping() -> String { return (_grouping == nil ? "" : "<Grouping>\(_grouping!)</Grouping>") }
	func eMailDetail() -> String { return (_eMailDetail == nil ? "" : "<EMailDetail>\(_eMailDetail!)</EMailDetail>") }
	func printDetail() -> String { return (_printDetail == nil ? "" : "<PrintDetail>\(_printDetail!)</PrintDetail>") }
}

final class ShippingDocumentEMailDetail : CustomStringConvertible
{
	fileprivate let _eMailRecipients: ShippingDocumentEMailRecipient?
	fileprivate let _grouping: ShippingDocumentEMailGroupingType?
	fileprivate let _localization: Localization?
	
	var description: String { return "\(eMailRecipients())\(grouping())\(localization())" }
	
	init(eMailRecipients: ShippingDocumentEMailRecipient, grouping: ShippingDocumentEMailGroupingType, localization: Localization)
	{
		_eMailRecipients = eMailRecipients
		_grouping = grouping
		_localization = localization
	}
	
	func eMailRecipients() -> String { return (_eMailRecipients == nil ? "" : "<EMailRecipients>\(_eMailRecipients!)</EMailRecipients>") }
	func grouping() -> String { return (_grouping == nil ? "" : "<Grouping>\(_grouping!)</Grouping>") }
	func localization() -> String { return (_localization == nil ? "" : "<Localization>\(_localization!)</Localization>") }
}

final class ShippingDocumentEMailRecipient : CustomStringConvertible
{
	fileprivate let _recipientType: EMailNotificationRecipientType?
	fileprivate let _address: String?
	
	var description: String { return "\(recipientType())\(address())" }
	
	init(recipientType: EMailNotificationRecipientType, address: String)
	{
		_recipientType = recipientType
		_address = address
	}
	
	func recipientType() -> String { return (_recipientType == nil ? "" : "<RecipientType>\(_recipientType!)</RecipientType>") }
	func address() -> String { return (_address == nil ? "" : "<Address>\(_address!)</Address>") }
}

struct ShippingDocumentPrintDetail : CustomStringConvertible
{
	fileprivate let _printerId: String?
	
	var description: String { return "\(printerId())" }
	
	init(printerId: String)
	{
		_printerId = printerId
	}
	
	func printerId() -> String { return (_printerId == nil ? "" : "<PrinterId>\(_printerId!)</PrinterId>") }
}

final class LinearMeasure : CustomStringConvertible
{
	fileprivate let _value: Decimal?
	fileprivate let _units: LinearUnits?
	
	var description: String { return "\(value())\(units())" }
	
	init(value: Decimal, units: LinearUnits)
	{
		_value = value
		_units = units
	}
	
	func value() -> String { return (_value == nil ? "" : "<Value>\(_value!)</Value>") }
	func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
}

final class DocumentFormatOptionsRequested : CustomStringConvertible
{
	fileprivate let _options: DocumentFormatOptionType?
	
	var description: String { return "\(options())" }
	
	init(options: DocumentFormatOptionType)
	{
		_options = options
	}
	
	func options() -> String { return (_options == nil ? "" : "<Options>\(_options!)</Options>") }
}

final class CustomerImageUsage : CustomStringConvertible
{
	fileprivate let _type: CustomerImageUsageType?
	fileprivate let _id: ImageId?
	
	var description: String { return "\(type())\(id())" }
	
	init(type: CustomerImageUsageType, id: ImageId)
	{
		_type = type
		_id = id
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func id() -> String { return (_id == nil ? "" : "<Id>\(_id!)</Id>") }
}

final class CommercialInvoiceDetail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	fileprivate let _customerImageUsages: CustomerImageUsage?
	
	var description: String { return "\(format())\(customerImageUsages())" }
	
	init(format: ShippingDocumentFormat, customerImageUsages: CustomerImageUsage)
	{
		_format = format
		_customerImageUsages = customerImageUsages
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func customerImageUsages() -> String { return (_customerImageUsages == nil ? "" : "<CustomerImageUsages>\(_customerImageUsages!)</CustomerImageUsages>") }
}

final class CustomDocumentDetail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	fileprivate let _labelPrintingOrientation: LabelPrintingOrientationType?
	fileprivate let _labelRotation: LabelRotationType?
	fileprivate let _specificationId: String?
	fileprivate let _customContent: CustomLabelDetail?
	
	var description: String { return "\(format())\(labelPrintingOrientation())\(labelRotation())\(specificationId())\(customContent())" }
	
	init(format: ShippingDocumentFormat, labelPrintingOrientation: LabelPrintingOrientationType, labelRotation: LabelRotationType, specificationId: String, customContent: CustomLabelDetail)
	{
		_format = format
		_labelPrintingOrientation = labelPrintingOrientation
		_labelRotation = labelRotation
		_specificationId = specificationId
		_customContent = customContent
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func labelPrintingOrientation() -> String { return (_labelPrintingOrientation == nil ? "" : "<LabelPrintingOrientation>\(_labelPrintingOrientation!)</LabelPrintingOrientation>") }
	func labelRotation() -> String { return (_labelRotation == nil ? "" : "<LabelRotation>\(_labelRotation!)</LabelRotation>") }
	func specificationId() -> String { return (_specificationId == nil ? "" : "<SpecificationId>\(_specificationId!)</SpecificationId>") }
	func customContent() -> String { return (_customContent == nil ? "" : "<CustomContent>\(_customContent!)</CustomContent>") }
}

final class CustomLabelDetail : CustomStringConvertible
{
	fileprivate let _coordinateUnits: CustomLabelCoordinateUnits?
	fileprivate let _textEntries: CustomLabelTextEntry?
	fileprivate let _graphicEntries: CustomLabelGraphicEntry?
	fileprivate let _boxEntries: CustomLabelBoxEntry?
	fileprivate let _textBoxEntries: CustomLabelTextBoxEntry?
	fileprivate let _barcodeEntries: CustomLabelBarcodeEntry?
	
	var description: String { return "\(coordinateUnits())\(textEntries())\(graphicEntries())\(boxEntries())\(textBoxEntries())\(barcodeEntries())" }
	
	init(coordinateUnits: CustomLabelCoordinateUnits, textEntries: CustomLabelTextEntry, graphicEntries: CustomLabelGraphicEntry, boxEntries: CustomLabelBoxEntry, textBoxEntries: CustomLabelTextBoxEntry, barcodeEntries: CustomLabelBarcodeEntry)
	{
		_coordinateUnits = coordinateUnits
		_textEntries = textEntries
		_graphicEntries = graphicEntries
		_boxEntries = boxEntries
		_textBoxEntries = textBoxEntries
		_barcodeEntries = barcodeEntries
	}
	
	func coordinateUnits() -> String { return (_coordinateUnits == nil ? "" : "<CoordinateUnits>\(_coordinateUnits!)</CoordinateUnits>") }
	func textEntries() -> String { return (_textEntries == nil ? "" : "<TextEntries>\(_textEntries!)</TextEntries>") }
	func graphicEntries() -> String { return (_graphicEntries == nil ? "" : "<GraphicEntries>\(_graphicEntries!)</GraphicEntries>") }
	func boxEntries() -> String { return (_boxEntries == nil ? "" : "<BoxEntries>\(_boxEntries!)</BoxEntries>") }
	func textBoxEntries() -> String { return (_textBoxEntries == nil ? "" : "<TextBoxEntries>\(_textBoxEntries!)</TextBoxEntries>") }
	func barcodeEntries() -> String { return (_barcodeEntries == nil ? "" : "<BarcodeEntries>\(_barcodeEntries!)</BarcodeEntries>") }
}

final class CustomLabelTextEntry : CustomStringConvertible
{
	fileprivate let _position: CustomLabelPosition?
	fileprivate let _format: String?
	fileprivate let _dataFields: String?
	fileprivate let _thermalFontId: String?
	fileprivate let _fontName: String?
	fileprivate let _fontSize: Int?
	fileprivate let _rotation: RotationType?
	
	var description: String { return "\(position())\(format())\(dataFields())\(thermalFontId())\(fontName())\(fontSize())\(rotation())" }
	
	init(position: CustomLabelPosition, format: String, dataFields: String, thermalFontId: String, fontName: String, fontSize: Int, rotation: RotationType)
	{
		_position = position
		_format = format
		_dataFields = dataFields
		_thermalFontId = thermalFontId
		_fontName = fontName
		_fontSize = fontSize
		_rotation = rotation
	}
	
	func position() -> String { return (_position == nil ? "" : "<Position>\(_position!)</Position>") }
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func dataFields() -> String { return (_dataFields == nil ? "" : "<DataFields>\(_dataFields!)</DataFields>") }
	func thermalFontId() -> String { return (_thermalFontId == nil ? "" : "<ThermalFontId>\(_thermalFontId!)</ThermalFontId>") }
	func fontName() -> String { return (_fontName == nil ? "" : "<FontName>\(_fontName!)</FontName>") }
	func fontSize() -> String { return (_fontSize == nil ? "" : "<FontSize>\(_fontSize!)</FontSize>") }
	func rotation() -> String { return (_rotation == nil ? "" : "<Rotation>\(_rotation!)</Rotation>") }
}

struct CustomLabelPosition : CustomStringConvertible
{
	fileprivate let _x: Int?
	fileprivate let _y: Int?
	
	var description: String { return "\(x())\(y())" }
	
	init(x: Int?, y: Int?)
	{
		_x = x
		_y = y
	}
	
	func x() -> String { return (_x == nil ? "" : "<X>\(_x!)</X>") }
	func y() -> String { return (_y == nil ? "" : "<Y>\(_y!)</Y>") }
}

final class CustomLabelGraphicEntry : CustomStringConvertible
{
	fileprivate let _position: CustomLabelPosition?
	fileprivate let _printerGraphicId: String?
	fileprivate let _fileGraphicFullName: String?
	
	var description: String { return "\(position())\(printerGraphicId())\(fileGraphicFullName())" }
	
	init(position: CustomLabelPosition, printerGraphicId: String, fileGraphicFullName: String)
	{
		_position = position
		_printerGraphicId = printerGraphicId
		_fileGraphicFullName = fileGraphicFullName
	}
	
	func position() -> String { return (_position == nil ? "" : "<Position>\(_position!)</Position>") }
	func printerGraphicId() -> String { return (_printerGraphicId == nil ? "" : "<PrinterGraphicId>\(_printerGraphicId!)</PrinterGraphicId>") }
	func fileGraphicFullName() -> String { return (_fileGraphicFullName == nil ? "" : "<FileGraphicFullName>\(_fileGraphicFullName!)</FileGraphicFullName>") }
}

final class CustomLabelBoxEntry : CustomStringConvertible
{
	fileprivate let _topLeftCorner: CustomLabelPosition?
	fileprivate let _bottomRightCorner: CustomLabelPosition?
	
	var description: String { return "\(topLeftCorner())\(bottomRightCorner())" }
	
	init(topLeftCorner: CustomLabelPosition, bottomRightCorner: CustomLabelPosition)
	{
		_topLeftCorner = topLeftCorner
		_bottomRightCorner = bottomRightCorner
	}
	
	func topLeftCorner() -> String { return (_topLeftCorner == nil ? "" : "<TopLeftCorner>\(_topLeftCorner!)</TopLeftCorner>") }
	func bottomRightCorner() -> String { return (_bottomRightCorner == nil ? "" : "<BottomRightCorner>\(_bottomRightCorner!)</BottomRightCorner>") }
}

final class CustomLabelTextBoxEntry : CustomStringConvertible
{
	fileprivate let _topLeftCorner: CustomLabelPosition?
	fileprivate let _bottomRightCorner: CustomLabelPosition?
	fileprivate let _position: CustomLabelPosition?
	fileprivate let _format: String?
	fileprivate let _dataFields: String?
	fileprivate let _thermalFontId: String?
	fileprivate let _fontName: String?
	fileprivate let _fontSize: Int?
	fileprivate let _rotation: RotationType?
	
	var description: String { return "\(topLeftCorner())\(bottomRightCorner())\(position())\(format())\(dataFields())\(thermalFontId())\(fontName())\(fontSize())\(rotation())" }
	
	init(topLeftCorner: CustomLabelPosition, bottomRightCorner: CustomLabelPosition, position: CustomLabelPosition, format: String, dataFields: String, thermalFontId: String, fontName: String, fontSize: Int, rotation: RotationType)
	{
		_topLeftCorner = topLeftCorner
		_bottomRightCorner = bottomRightCorner
		_position = position
		_format = format
		_dataFields = dataFields
		_thermalFontId = thermalFontId
		_fontName = fontName
		_fontSize = fontSize
		_rotation = rotation
	}
	
	func topLeftCorner() -> String { return (_topLeftCorner == nil ? "" : "<TopLeftCorner>\(_topLeftCorner!)</TopLeftCorner>") }
	func bottomRightCorner() -> String { return (_bottomRightCorner == nil ? "" : "<BottomRightCorner>\(_bottomRightCorner!)</BottomRightCorner>") }
	func position() -> String { return (_position == nil ? "" : "<Position>\(_position!)</Position>") }
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func dataFields() -> String { return (_dataFields == nil ? "" : "<DataFields>\(_dataFields!)</DataFields>") }
	func thermalFontId() -> String { return (_thermalFontId == nil ? "" : "<ThermalFontId>\(_thermalFontId!)</ThermalFontId>") }
	func fontName() -> String { return (_fontName == nil ? "" : "<FontName>\(_fontName!)</FontName>") }
	func fontSize() -> String { return (_fontSize == nil ? "" : "<FontSize>\(_fontSize!)</FontSize>") }
	func rotation() -> String { return (_rotation == nil ? "" : "<Rotation>\(_rotation!)</Rotation>") }
}

final class CustomLabelBarcodeEntry : CustomStringConvertible
{
	fileprivate let _position: CustomLabelPosition?
	fileprivate let _format: String?
	fileprivate let _dataFields: String?
	fileprivate let _barHeight: Int?
	fileprivate let _thinBarWidth: Int?
	fileprivate let _barcodeSymbology: BarcodeSymbologyType?
	
	var description: String { return "\(position())\(format())\(dataFields())\(barHeight())\(thinBarWidth())\(barcodeSymbology())" }
	
	init(position: CustomLabelPosition, format: String, dataFields: String, barHeight: Int, thinBarWidth: Int, barcodeSymbology: BarcodeSymbologyType)
	{
		_position = position
		_format = format
		_dataFields = dataFields
		_barHeight = barHeight
		_thinBarWidth = thinBarWidth
		_barcodeSymbology = barcodeSymbology
	}
	
	func position() -> String { return (_position == nil ? "" : "<Position>\(_position!)</Position>") }
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func dataFields() -> String { return (_dataFields == nil ? "" : "<DataFields>\(_dataFields!)</DataFields>") }
	func barHeight() -> String { return (_barHeight == nil ? "" : "<BarHeight>\(_barHeight!)</BarHeight>") }
	func thinBarWidth() -> String { return (_thinBarWidth == nil ? "" : "<ThinBarWidth>\(_thinBarWidth!)</ThinBarWidth>") }
	func barcodeSymbology() -> String { return (_barcodeSymbology == nil ? "" : "<BarcodeSymbology>\(_barcodeSymbology!)</BarcodeSymbology>") }
}

final class ExportDeclarationDetail : CustomStringConvertible
{
	fileprivate let _documentFormat: ShippingDocumentFormat?
	fileprivate let _customerImageUsages: CustomerImageUsage?
	
	var description: String { return "\(documentFormat())\(customerImageUsages())" }
	
	init(documentFormat: ShippingDocumentFormat, customerImageUsages: CustomerImageUsage)
	{
		_documentFormat = documentFormat
		_customerImageUsages = customerImageUsages
	}
	
	func documentFormat() -> String { return (_documentFormat == nil ? "" : "<DocumentFormat>\(_documentFormat!)</DocumentFormat>") }
	func customerImageUsages() -> String { return (_customerImageUsages == nil ? "" : "<CustomerImageUsages>\(_customerImageUsages!)</CustomerImageUsages>") }
}

final class GeneralAgencyAgreementDetail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	
	var description: String { return "\(format())" }
	
	init(format: ShippingDocumentFormat)
	{
		_format = format
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
}

final class NaftaCertificateOfOriginDetail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	fileprivate let _blanketPeriod: DateRange?
	fileprivate let _importerSpecification: NaftaImporterSpecificationType?
	fileprivate let _signatureContact: Contact?
	fileprivate let _producerSpecification: NaftaProducerSpecificationType?
	fileprivate let _producers: NaftaProducer?
	fileprivate let _customerImageUsages: CustomerImageUsage?
	
	var description: String { return "\(format())\(blanketPeriod())\(importerSpecification())\(signatureContact())\(producerSpecification())\(producers())\(customerImageUsages())" }
	
	init(format: ShippingDocumentFormat, blanketPeriod: DateRange, importerSpecification: NaftaImporterSpecificationType, signatureContact: Contact, producerSpecification: NaftaProducerSpecificationType, producers: NaftaProducer, customerImageUsages: CustomerImageUsage)
	{
		_format = format
		_blanketPeriod = blanketPeriod
		_importerSpecification = importerSpecification
		_signatureContact = signatureContact
		_producerSpecification = producerSpecification
		_producers = producers
		_customerImageUsages = customerImageUsages
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func blanketPeriod() -> String { return (_blanketPeriod == nil ? "" : "<BlanketPeriod>\(_blanketPeriod!)</BlanketPeriod>") }
	func importerSpecification() -> String { return (_importerSpecification == nil ? "" : "<ImporterSpecification>\(_importerSpecification!)</ImporterSpecification>") }
	func signatureContact() -> String { return (_signatureContact == nil ? "" : "<SignatureContact>\(_signatureContact!)</SignatureContact>") }
	func producerSpecification() -> String { return (_producerSpecification == nil ? "" : "<ProducerSpecification>\(_producerSpecification!)</ProducerSpecification>") }
	func producers() -> String { return (_producers == nil ? "" : "<Producers>\(_producers!)</Producers>") }
	func customerImageUsages() -> String { return (_customerImageUsages == nil ? "" : "<CustomerImageUsages>\(_customerImageUsages!)</CustomerImageUsages>") }
}

final class NaftaProducer : CustomStringConvertible
{
	fileprivate let _id: String?
	fileprivate let _producer: Party?
	
	var description: String { return "\(id())\(producer())" }
	
	init(id: String, producer: Party)
	{
		_id = id
		_producer = producer
	}
	
	func id() -> String { return (_id == nil ? "" : "<Id>\(_id!)</Id>") }
	func producer() -> String { return (_producer == nil ? "" : "<Producer>\(_producer!)</Producer>") }
}

final class Op900Detail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	fileprivate let _reference: CustomerReferenceType?
	fileprivate let _customerImageUsages: CustomerImageUsage?
	fileprivate let _signatureName: String?
	
	var description: String { return "\(format())\(reference())\(customerImageUsages())\(signatureName())" }
	
	init(format: ShippingDocumentFormat, reference: CustomerReferenceType, customerImageUsages: CustomerImageUsage, signatureName: String)
	{
		_format = format
		_reference = reference
		_customerImageUsages = customerImageUsages
		_signatureName = signatureName
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func reference() -> String { return (_reference == nil ? "" : "<Reference>\(_reference!)</Reference>") }
	func customerImageUsages() -> String { return (_customerImageUsages == nil ? "" : "<CustomerImageUsages>\(_customerImageUsages!)</CustomerImageUsages>") }
	func signatureName() -> String { return (_signatureName == nil ? "" : "<SignatureName>\(_signatureName!)</SignatureName>") }
}

final class DangerousGoodsShippersDeclarationDetail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	fileprivate let _customerImageUsages: CustomerImageUsage?
	
	var description: String { return "\(format())\(customerImageUsages())" }
	
	init(format: ShippingDocumentFormat, customerImageUsages: CustomerImageUsage)
	{
		_format = format
		_customerImageUsages = customerImageUsages
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func customerImageUsages() -> String { return (_customerImageUsages == nil ? "" : "<CustomerImageUsages>\(_customerImageUsages!)</CustomerImageUsages>") }
}

final class FreightAddressLabelDetail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	fileprivate let _copies: UInt?
	fileprivate let _startingPosition: PageQuadrantType?
	fileprivate let _docTabContent: DocTabContent?
	fileprivate let _customContentPosition: RelativeVerticalPositionType?
	fileprivate let _customContent: CustomLabelDetail?
	
	var description: String { return "\(format())\(copies())\(startingPosition())\(docTabContent())\(customContentPosition())\(customContent())" }
	
	init(format: ShippingDocumentFormat, copies: UInt, startingPosition: PageQuadrantType, docTabContent: DocTabContent, customContentPosition: RelativeVerticalPositionType, customContent: CustomLabelDetail)
	{
		_format = format
		_copies = copies
		_startingPosition = startingPosition
		_docTabContent = docTabContent
		_customContentPosition = customContentPosition
		_customContent = customContent
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func copies() -> String { return (_copies == nil ? "" : "<Copies>\(_copies!)</Copies>") }
	func startingPosition() -> String { return (_startingPosition == nil ? "" : "<StartingPosition>\(_startingPosition!)</StartingPosition>") }
	func docTabContent() -> String { return (_docTabContent == nil ? "" : "<DocTabContent>\(_docTabContent!)</DocTabContent>") }
	func customContentPosition() -> String { return (_customContentPosition == nil ? "" : "<CustomContentPosition>\(_customContentPosition!)</CustomContentPosition>") }
	func customContent() -> String { return (_customContent == nil ? "" : "<CustomContent>\(_customContent!)</CustomContent>") }
}

final class DocTabContent : CustomStringConvertible
{
	fileprivate let _docTabContentType: DocTabContentType?
	fileprivate let _zone001: DocTabContentZone001?
	fileprivate let _barcoded: DocTabContentBarcoded?
	
	var description: String { return "\(docTabContentType())\(zone001())\(barcoded())" }
	
	init(docTabContentType: DocTabContentType, zone001: DocTabContentZone001, barcoded: DocTabContentBarcoded)
	{
		_docTabContentType = docTabContentType
		_zone001 = zone001
		_barcoded = barcoded
	}
	
	func docTabContentType() -> String { return (_docTabContentType == nil ? "" : "<DocTabContentType>\(_docTabContentType!)</DocTabContentType>") }
	func zone001() -> String { return (_zone001 == nil ? "" : "<Zone001>\(_zone001!)</Zone001>") }
	func barcoded() -> String { return (_barcoded == nil ? "" : "<Barcoded>\(_barcoded!)</Barcoded>") }
}

final class DocTabContentZone001 : CustomStringConvertible
{
	fileprivate let _docTabZoneSpecifications: DocTabZoneSpecification?
	
	var description: String { return "\(docTabZoneSpecifications())" }
	
	init(docTabZoneSpecifications: DocTabZoneSpecification)
	{
		_docTabZoneSpecifications = docTabZoneSpecifications
	}
	
	func docTabZoneSpecifications() -> String { return (_docTabZoneSpecifications == nil ? "" : "<DocTabZoneSpecifications>\(_docTabZoneSpecifications!)</DocTabZoneSpecifications>") }
}

final class DocTabZoneSpecification : CustomStringConvertible
{
	fileprivate let _zoneNumber: Int?
	fileprivate let _header: String?
	fileprivate let _dataField: String?
	fileprivate let _literalValue: String?
	fileprivate let _justification: DocTabZoneJustificationType?
	
	var description: String { return "\(zoneNumber())\(header())\(dataField())\(literalValue())\(justification())" }
	
	init(zoneNumber: Int, header: String, dataField: String, literalValue: String, justification: DocTabZoneJustificationType)
	{
		_zoneNumber = zoneNumber
		_header = header
		_dataField = dataField
		_literalValue = literalValue
		_justification = justification
	}
	
	func zoneNumber() -> String { return (_zoneNumber == nil ? "" : "<ZoneNumber>\(_zoneNumber!)</ZoneNumber>") }
	func header() -> String { return (_header == nil ? "" : "<Header>\(_header!)</Header>") }
	func dataField() -> String { return (_dataField == nil ? "" : "<DataField>\(_dataField!)</DataField>") }
	func literalValue() -> String { return (_literalValue == nil ? "" : "<LiteralValue>\(_literalValue!)</LiteralValue>") }
	func justification() -> String { return (_justification == nil ? "" : "<Justification>\(_justification!)</Justification>") }
}

final class DocTabContentBarcoded : CustomStringConvertible
{
	fileprivate let _symbology: BarcodeSymbologyType?
	fileprivate let _specification: DocTabZoneSpecification?
	
	var description: String { return "\(symbology())\(specification())" }
	
	init(symbology: BarcodeSymbologyType, specification: DocTabZoneSpecification)
	{
		_symbology = symbology
		_specification = specification
	}
	
	func symbology() -> String { return (_symbology == nil ? "" : "<Symbology>\(_symbology!)</Symbology>") }
	func specification() -> String { return (_specification == nil ? "" : "<Specification>\(_specification!)</Specification>") }
}

final class ReturnInstructionsDetail : CustomStringConvertible
{
	fileprivate let _format: ShippingDocumentFormat?
	fileprivate let _customText: String?
	
	var description: String { return "\(format())\(customText())" }
	
	init(format: ShippingDocumentFormat, customText: String)
	{
		_format = format
		_customText = customText
	}
	
	func format() -> String { return (_format == nil ? "" : "<Format>\(_format!)</Format>") }
	func customText() -> String { return (_customText == nil ? "" : "<CustomText>\(_customText!)</CustomText>") }
}

final class CustomerSpecifiedLabelDetail : CustomStringConvertible
{
	fileprivate let _docTabContent: DocTabContent?
	fileprivate let _customContentPosition : RelativeVerticalPositionType?
	fileprivate let _customContent: CustomLabelDetail?
	fileprivate let _configurableReferenceEntries: ConfigurableLabelReferenceEntry?
	fileprivate let _maskedData: LabelMaskableDataType?
	fileprivate let _secondaryBarcode: SecondaryBarcodeType?
	fileprivate let _termsAndConditionsLocalization: Localization?
	fileprivate let _regulatoryLabels: RegulatoryLabelContentDetail?
	fileprivate let _additionalLabels: AdditionalLabelsDetail?
	fileprivate let _airWaybillSuppressionCount: UInt?
	
	var description: String { return "\(docTabContent())\(customContentPosition ())\(customContent())\(configurableReferenceEntries())\(maskedData())\(secondaryBarcode())\(termsAndConditionsLocalization())\(regulatoryLabels())\(additionalLabels())\(airWaybillSuppressionCount())" }
	
	init(docTabContent: DocTabContent, customContentPosition : RelativeVerticalPositionType, customContent: CustomLabelDetail, configurableReferenceEntries: ConfigurableLabelReferenceEntry, maskedData: LabelMaskableDataType, secondaryBarcode: SecondaryBarcodeType, termsAndConditionsLocalization: Localization, regulatoryLabels: RegulatoryLabelContentDetail, additionalLabels: AdditionalLabelsDetail, airWaybillSuppressionCount: UInt)
	{
		_docTabContent = docTabContent
		_customContentPosition  = customContentPosition
		_customContent = customContent
		_configurableReferenceEntries = configurableReferenceEntries
		_maskedData = maskedData
		_secondaryBarcode = secondaryBarcode
		_termsAndConditionsLocalization = termsAndConditionsLocalization
		_regulatoryLabels = regulatoryLabels
		_additionalLabels = additionalLabels
		_airWaybillSuppressionCount = airWaybillSuppressionCount
	}
	
	func docTabContent() -> String { return (_docTabContent == nil ? "" : "<DocTabContent>\(_docTabContent!)</DocTabContent>") }
	func customContentPosition () -> String { return (_customContentPosition  == nil ? "" : "<CustomContentPosition >\(_customContentPosition!)</CustomContentPosition >") }
	func customContent() -> String { return (_customContent == nil ? "" : "<CustomContent>\(_customContent!)</CustomContent>") }
	func configurableReferenceEntries() -> String { return (_configurableReferenceEntries == nil ? "" : "<ConfigurableReferenceEntries>\(_configurableReferenceEntries!)</ConfigurableReferenceEntries>") }
	func maskedData() -> String { return (_maskedData == nil ? "" : "<MaskedData>\(_maskedData!)</MaskedData>") }
	func secondaryBarcode() -> String { return (_secondaryBarcode == nil ? "" : "<SecondaryBarcode>\(_secondaryBarcode!)</SecondaryBarcode>") }
	func termsAndConditionsLocalization() -> String { return (_termsAndConditionsLocalization == nil ? "" : "<TermsAndConditionsLocalization>\(_termsAndConditionsLocalization!)</TermsAndConditionsLocalization>") }
	func regulatoryLabels() -> String { return (_regulatoryLabels == nil ? "" : "<RegulatoryLabels>\(_regulatoryLabels!)</RegulatoryLabels>") }
	func additionalLabels() -> String { return (_additionalLabels == nil ? "" : "<AdditionalLabels>\(_additionalLabels!)</AdditionalLabels>") }
	func airWaybillSuppressionCount() -> String { return (_airWaybillSuppressionCount == nil ? "" : "<AirWaybillSuppressionCount>\(_airWaybillSuppressionCount!)</AirWaybillSuppressionCount>") }
}

struct ConfigurableLabelReferenceEntry : CustomStringConvertible
{
	fileprivate let _zoneNumber: Int?
	fileprivate let _header: String?
	fileprivate let _dataField: String?
	fileprivate let _literalValue: String?
	
	var description: String { return "\(zoneNumber())\(header())\(dataField())\(literalValue())" }
	
	init(zoneNumber: Int, header: String, dataField: String, literalValue: String)
	{
		_zoneNumber = zoneNumber
		_header = header
		_dataField = dataField
		_literalValue = literalValue
	}
	
	func zoneNumber() -> String { return (_zoneNumber == nil ? "" : "<ZoneNumber>\(_zoneNumber!)</ZoneNumber>") }
	func header() -> String { return (_header == nil ? "" : "<Header>\(_header!)</Header>") }
	func dataField() -> String { return (_dataField == nil ? "" : "<DataField>\(_dataField!)</DataField>") }
	func literalValue() -> String { return (_literalValue == nil ? "" : "<LiteralValue>\(_literalValue!)</LiteralValue>") }
}

final class RegulatoryLabelContentDetail : CustomStringConvertible
{
	fileprivate let _type: RegulatoryLabelType?
	fileprivate let _generationOptions: CustomerSpecifiedLabelGenerationOptionType?
	
	var description: String { return "\(type())\(generationOptions())" }
	
	init(type: RegulatoryLabelType, generationOptions: CustomerSpecifiedLabelGenerationOptionType)
	{
		_type = type
		_generationOptions = generationOptions
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func generationOptions() -> String { return (_generationOptions == nil ? "" : "<GenerationOptions>\(_generationOptions!)</GenerationOptions>") }
}

final class AdditionalLabelsDetail : CustomStringConvertible
{
	fileprivate let _type: AdditionalLabelsType?
	fileprivate let _count: UInt?
	
	var description: String { return "\(type())\(count())" }
	
	init(type: AdditionalLabelsType, count: UInt)
	{
		_type = type
		_count = count
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func count() -> String { return (_count == nil ? "" : "<Count>\(_count!)</Count>") }
}

final class ShipmentConfigurationData : CustomStringConvertible
{
	fileprivate let _dangerousGoodsPackageConfigurations: DangerousGoodsDetail?
	
	var description: String { return "\(dangerousGoodsPackageConfigurations())" }
	
	init(dangerousGoodsPackageConfigurations: DangerousGoodsDetail)
	{
		_dangerousGoodsPackageConfigurations = dangerousGoodsPackageConfigurations
	}
	
	func dangerousGoodsPackageConfigurations() -> String { return (_dangerousGoodsPackageConfigurations == nil ? "" : "<DangerousGoodsPackageConfigurations>\(_dangerousGoodsPackageConfigurations!)</DangerousGoodsPackageConfigurations>") }
}

final class DangerousGoodsDetail : CustomStringConvertible
{
	let _regulation: HazardousCommodityRegulationType?
	let _accessibility: DangerousGoodsAccessibilityType?
	let _cargoAircraftOnly: Bool?
	let _options: HazardousCommodityOptionType?
	let _packingOption: DangerousGoodsPackingOptionType?
	let _referenceId: String?
	let _containers: DangerousGoodsContainer?
	let _packaging: HazardousCommodityPackagingDetail?
	let _signatory: DangerousGoodsSignatory?
	let _emergencyContactNumber: String?
	let _offeror: String?
	let _infectiousSubstanceResponsibleContact: Contact?
	let _additionalHandling: String?
	let _radioactivityDetail: RadioactivityDetail?
	
	var description: String { return "\(regulation())\(accessibility())\(cargoAircraftOnly())\(options())\(packingOption())\(referenceId())\(containers())\(packaging())\(signatory())\(emergencyContactNumber())\(offeror())\(infectiousSubstanceResponsibleContact())\(additionalHandling())\(radioactivityDetail())" }
	
	init(accessibility: DangerousGoodsAccessibilityType?)
	{
		_regulation = nil
		_accessibility = accessibility
		_cargoAircraftOnly = nil
		_options = nil
		_packingOption = nil
		_referenceId = nil
		_containers = nil
		_packaging = nil
		_signatory = nil
		_emergencyContactNumber = nil
		_offeror = nil
		_infectiousSubstanceResponsibleContact = nil
		_additionalHandling = nil
		_radioactivityDetail = nil
	}
	
	fileprivate func regulation() -> String { return (_regulation == nil ? "" : "<Regulation>\(_regulation!)</Regulation>") }
	fileprivate func accessibility() -> String { return (_accessibility == nil ? "" : "<Accessibility>\(_accessibility!)</Accessibility>") }
	fileprivate func cargoAircraftOnly() -> String { return (_cargoAircraftOnly == nil ? "" : "<CargoAircraftOnly>\(_cargoAircraftOnly!)</CargoAircraftOnly>") }
	fileprivate func options() -> String { return (_options == nil ? "" : "<Options>\(_options!)</Options>") }
	fileprivate func packingOption() -> String { return (_packingOption == nil ? "" : "<PackingOption>\(_packingOption!)</PackingOption>") }
	fileprivate func referenceId() -> String { return (_referenceId == nil ? "" : "<ReferenceId>\(_referenceId!)</ReferenceId>") }
	fileprivate func containers() -> String { return (_containers == nil ? "" : "<Containers>\(_containers!)</Containers>") }
	fileprivate func packaging() -> String { return (_packaging == nil ? "" : "<Packaging>\(_packaging!)</Packaging>") }
	fileprivate func signatory() -> String { return (_signatory == nil ? "" : "<Signatory>\(_signatory!)</Signatory>") }
	fileprivate func emergencyContactNumber() -> String { return (_emergencyContactNumber == nil ? "" : "<EmergencyContactNumber>\(_emergencyContactNumber!)</EmergencyContactNumber>") }
	fileprivate func offeror() -> String { return (_offeror == nil ? "" : "<Offeror>\(_offeror!)</Offeror>") }
	fileprivate func infectiousSubstanceResponsibleContact() -> String { return (_infectiousSubstanceResponsibleContact == nil ? "" : "<InfectiousSubstanceResponsibleContact>\(_infectiousSubstanceResponsibleContact!)</InfectiousSubstanceResponsibleContact>") }
	fileprivate func additionalHandling() -> String { return (_additionalHandling == nil ? "" : "<AdditionalHandling>\(_additionalHandling!)</AdditionalHandling>") }
	fileprivate func radioactivityDetail() -> String { return (_radioactivityDetail == nil ? "" : "<RadioactivityDetail>\(_radioactivityDetail!)</RadioactivityDetail>") }
}

final class DangerousGoodsContainer : CustomStringConvertible
{
	fileprivate let _packingType: HazardousContainerPackingType?
	fileprivate let _containerType: String?
	fileprivate let _radioactiveContainerClass: RadioactiveContainerClassType?
	fileprivate let _numberOfContainers: UInt?
	fileprivate let _hazardousCommodities: HazardousCommodityContent?
	
	var description: String { return "\(packingType())\(containerType())\(radioactiveContainerClass())\(numberOfContainers())\(hazardousCommodities())" }
	
	init(packingType: HazardousContainerPackingType, containerType: String, radioactiveContainerClass: RadioactiveContainerClassType, numberOfContainers: UInt, hazardousCommodities: HazardousCommodityContent)
	{
		_packingType = packingType
		_containerType = containerType
		_radioactiveContainerClass = radioactiveContainerClass
		_numberOfContainers = numberOfContainers
		_hazardousCommodities = hazardousCommodities
	}
	
	func packingType() -> String { return (_packingType == nil ? "" : "<PackingType>\(_packingType!)</PackingType>") }
	func containerType() -> String { return (_containerType == nil ? "" : "<ContainerType>\(_containerType!)</ContainerType>") }
	func radioactiveContainerClass() -> String { return (_radioactiveContainerClass == nil ? "" : "<RadioactiveContainerClass>\(_radioactiveContainerClass!)</RadioactiveContainerClass>") }
	func numberOfContainers() -> String { return (_numberOfContainers == nil ? "" : "<NumberOfContainers>\(_numberOfContainers!)</NumberOfContainers>") }
	func hazardousCommodities() -> String { return (_hazardousCommodities == nil ? "" : "<HazardousCommodities>\(_hazardousCommodities!)</HazardousCommodities>") }
}

final class HazardousCommodityContent : CustomStringConvertible
{
	fileprivate let _description: HazardousCommodityDescription?
	fileprivate let _quantity: HazardousCommodityQuantityDetail?
	fileprivate let _innerReceptacles: HazardousCommodityInnerReceptacleDetail?
	fileprivate let _options: HazardousCommodityOptionDetail?
	fileprivate let _radionuclideDetail: RadionuclideDetail?
	fileprivate let _netExplosiveDetail: NetExplosiveDetail?
	
	var description: String { return "\(description_())\(quantity())\(innerReceptacles())\(options())\(radionuclideDetail())\(netExplosiveDetail())" }
	
	init(description: HazardousCommodityDescription, quantity: HazardousCommodityQuantityDetail, innerReceptacles: HazardousCommodityInnerReceptacleDetail, options: HazardousCommodityOptionDetail, radionuclideDetail: RadionuclideDetail, netExplosiveDetail: NetExplosiveDetail)
	{
		_description = description
		_quantity = quantity
		_innerReceptacles = innerReceptacles
		_options = options
		_radionuclideDetail = radionuclideDetail
		_netExplosiveDetail = netExplosiveDetail
	}
	
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func quantity() -> String { return (_quantity == nil ? "" : "<Quantity>\(_quantity!)</Quantity>") }
	func innerReceptacles() -> String { return (_innerReceptacles == nil ? "" : "<InnerReceptacles>\(_innerReceptacles!)</InnerReceptacles>") }
	func options() -> String { return (_options == nil ? "" : "<Options>\(_options!)</Options>") }
	func radionuclideDetail() -> String { return (_radionuclideDetail == nil ? "" : "<RadionuclideDetail>\(_radionuclideDetail!)</RadionuclideDetail>") }
	func netExplosiveDetail() -> String { return (_netExplosiveDetail == nil ? "" : "<NetExplosiveDetail>\(_netExplosiveDetail!)</NetExplosiveDetail>") }
}

final class HazardousCommodityDescription : CustomStringConvertible
{
	fileprivate let _id: String?
	fileprivate let _sequenceNumber: UInt?
	fileprivate let _packingGroup: HazardousCommodityPackingGroupType?
	fileprivate let _packingDetails: HazardousCommodityPackingDetail?
	fileprivate let _reportableQuantity: Bool?
	fileprivate let _properShippingName: String?
	fileprivate let _technicalName: String?
	fileprivate let _percentage: Decimal?
	fileprivate let _hazardClass: String?
	fileprivate let _subsidiaryClasses: String?
	fileprivate let _labelText: String?
	fileprivate let _processingOptions: HazardousCommodityDescriptionProcessingOptionType?
	fileprivate let _authorization: String?
	
	var description: String { return "\(id())\(sequenceNumber())\(packingGroup())\(packingDetails())\(reportableQuantity())\(properShippingName())\(technicalName())\(percentage())\(hazardClass())\(subsidiaryClasses())\(labelText())\(processingOptions())\(authorization())" }
	
	init(id: String, sequenceNumber: UInt, packingGroup: HazardousCommodityPackingGroupType, packingDetails: HazardousCommodityPackingDetail, reportableQuantity: Bool, properShippingName: String, technicalName: String, percentage: Decimal, hazardClass: String, subsidiaryClasses: String, labelText: String, processingOptions: HazardousCommodityDescriptionProcessingOptionType, authorization: String)
	{
		_id = id
		_sequenceNumber = sequenceNumber
		_packingGroup = packingGroup
		_packingDetails = packingDetails
		_reportableQuantity = reportableQuantity
		_properShippingName = properShippingName
		_technicalName = technicalName
		_percentage = percentage
		_hazardClass = hazardClass
		_subsidiaryClasses = subsidiaryClasses
		_labelText = labelText
		_processingOptions = processingOptions
		_authorization = authorization
	}
	
	func id() -> String { return (_id == nil ? "" : "<Id>\(_id!)</Id>") }
	func sequenceNumber() -> String { return (_sequenceNumber == nil ? "" : "<SequenceNumber>\(_sequenceNumber!)</SequenceNumber>") }
	func packingGroup() -> String { return (_packingGroup == nil ? "" : "<PackingGroup>\(_packingGroup!)</PackingGroup>") }
	func packingDetails() -> String { return (_packingDetails == nil ? "" : "<PackingDetails>\(_packingDetails!)</PackingDetails>") }
	func reportableQuantity() -> String { return (_reportableQuantity == nil ? "" : "<ReportableQuantity>\(_reportableQuantity!)</ReportableQuantity>") }
	func properShippingName() -> String { return (_properShippingName == nil ? "" : "<ProperShippingName>\(_properShippingName!)</ProperShippingName>") }
	func technicalName() -> String { return (_technicalName == nil ? "" : "<TechnicalName>\(_technicalName!)</TechnicalName>") }
	func percentage() -> String { return (_percentage == nil ? "" : "<Percentage>\(_percentage!)</Percentage>") }
	func hazardClass() -> String { return (_hazardClass == nil ? "" : "<HazardClass>\(_hazardClass!)</HazardClass>") }
	func subsidiaryClasses() -> String { return (_subsidiaryClasses == nil ? "" : "<SubsidiaryClasses>\(_subsidiaryClasses!)</SubsidiaryClasses>") }
	func labelText() -> String { return (_labelText == nil ? "" : "<LabelText>\(_labelText!)</LabelText>") }
	func processingOptions() -> String { return (_processingOptions == nil ? "" : "<ProcessingOptions>\(_processingOptions!)</ProcessingOptions>") }
	func authorization() -> String { return (_authorization == nil ? "" : "<Authorization>\(_authorization!)</Authorization>") }
}

struct HazardousCommodityPackingDetail : CustomStringConvertible
{
	fileprivate let _cargoAircraftOnly: Bool?
	fileprivate let _packingInstructions: String?
	
	var description: String { return "\(cargoAircraftOnly())\(packingInstructions())" }
	
	init(cargoAircraftOnly: Bool, packingInstructions: String)
	{
		_cargoAircraftOnly = cargoAircraftOnly
		_packingInstructions = packingInstructions
	}
	
	func cargoAircraftOnly() -> String { return (_cargoAircraftOnly == nil ? "" : "<CargoAircraftOnly>\(_cargoAircraftOnly!)</CargoAircraftOnly>") }
	func packingInstructions() -> String { return (_packingInstructions == nil ? "" : "<PackingInstructions>\(_packingInstructions!)</PackingInstructions>") }
}

final class HazardousCommodityQuantityDetail : CustomStringConvertible
{
	fileprivate let _amount: Decimal?
	fileprivate let _units: String?
	fileprivate let _quantityType : HazardousCommodityQuantityType?
	
	var description: String { return "\(amount())\(units())\(quantityType ())" }
	
	init(amount: Decimal, units: String, quantityType : HazardousCommodityQuantityType)
	{
		_amount = amount
		_units = units
		_quantityType  = quantityType
	}
	
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
	func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
	func quantityType () -> String { return (_quantityType  == nil ? "" : "<QuantityType >\(_quantityType!)</QuantityType >") }
}

final class HazardousCommodityInnerReceptacleDetail : CustomStringConvertible
{
	fileprivate let _quantity: HazardousCommodityQuantityDetail?
	
	var description: String { return "\(quantity())" }
	
	init(quantity: HazardousCommodityQuantityDetail)
	{
		_quantity = quantity
	}
	
	func quantity() -> String { return (_quantity == nil ? "" : "<Quantity>\(_quantity!)</Quantity>") }
}

final class HazardousCommodityOptionDetail : CustomStringConvertible
{
	fileprivate let _labelTextOption: HazardousCommodityLabelTextOptionType?
	fileprivate let _customerSuppliedLabelText: String?
	
	var description: String { return "\(labelTextOption())\(customerSuppliedLabelText())" }
	
	init(labelTextOption: HazardousCommodityLabelTextOptionType, customerSuppliedLabelText: String)
	{
		_labelTextOption = labelTextOption
		_customerSuppliedLabelText = customerSuppliedLabelText
	}
	
	func labelTextOption() -> String { return (_labelTextOption == nil ? "" : "<LabelTextOption>\(_labelTextOption!)</LabelTextOption>") }
	func customerSuppliedLabelText() -> String { return (_customerSuppliedLabelText == nil ? "" : "<CustomerSuppliedLabelText>\(_customerSuppliedLabelText!)</CustomerSuppliedLabelText>") }
}

final class RadionuclideDetail : CustomStringConvertible
{
	fileprivate let _radionuclide: String?
	fileprivate let _activity: RadionuclideActivity?
	fileprivate let _exceptedPackagingIsReportableQuantity: Bool?
	fileprivate let _physicalForm: PhysicalFormType?
	fileprivate let _chemicalForm: String?
	
	var description: String { return "\(radionuclide())\(activity())\(exceptedPackagingIsReportableQuantity())\(physicalForm())\(chemicalForm())" }
	
	init(radionuclide: String, activity: RadionuclideActivity, exceptedPackagingIsReportableQuantity: Bool, physicalForm: PhysicalFormType, chemicalForm: String)
	{
		_radionuclide = radionuclide
		_activity = activity
		_exceptedPackagingIsReportableQuantity = exceptedPackagingIsReportableQuantity
		_physicalForm = physicalForm
		_chemicalForm = chemicalForm
	}
	
	func radionuclide() -> String { return (_radionuclide == nil ? "" : "<Radionuclide>\(_radionuclide!)</Radionuclide>") }
	func activity() -> String { return (_activity == nil ? "" : "<Activity>\(_activity!)</Activity>") }
	func exceptedPackagingIsReportableQuantity() -> String { return (_exceptedPackagingIsReportableQuantity == nil ? "" : "<ExceptedPackagingIsReportableQuantity>\(_exceptedPackagingIsReportableQuantity!)</ExceptedPackagingIsReportableQuantity>") }
	func physicalForm() -> String { return (_physicalForm == nil ? "" : "<PhysicalForm>\(_physicalForm!)</PhysicalForm>") }
	func chemicalForm() -> String { return (_chemicalForm == nil ? "" : "<ChemicalForm>\(_chemicalForm!)</ChemicalForm>") }
}

final class RadionuclideActivity : CustomStringConvertible
{
	fileprivate let _value: Decimal?
	fileprivate let _unitOfMeasure: RadioactivityUnitOfMeasure?
	
	var description: String { return "\(value())\(unitOfMeasure())" }
	
	init(value: Decimal, unitOfMeasure: RadioactivityUnitOfMeasure)
	{
		_value = value
		_unitOfMeasure = unitOfMeasure
	}
	
	func value() -> String { return (_value == nil ? "" : "<Value>\(_value!)</Value>") }
	func unitOfMeasure() -> String { return (_unitOfMeasure == nil ? "" : "<UnitOfMeasure>\(_unitOfMeasure!)</UnitOfMeasure>") }
}

final class NetExplosiveDetail : CustomStringConvertible
{
	fileprivate let _type: NetExplosiveClassificationType?
	fileprivate let _amount: Decimal?
	fileprivate let _units: String?
	
	var description: String { return "\(type())\(amount())\(units())" }
	
	init(type: NetExplosiveClassificationType, amount: Decimal, units: String)
	{
		_type = type
		_amount = amount
		_units = units
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
	func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
}

struct HazardousCommodityPackagingDetail : CustomStringConvertible
{
	fileprivate let _count: Int?
	fileprivate let _units: String?
	
	var description: String { return "\(count())\(units())" }
	
	init(count: Int?, units: String?)
	{
		_count = count
		_units = units
	}
	
	func count() -> String { return (_count == nil ? "" : "<Count>\(_count!)</Count>") }
	func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
}

struct DangerousGoodsSignatory : CustomStringConvertible
{
	fileprivate let _contactName: String?
	fileprivate let _title: String?
	fileprivate let _place: String?
	
	var description: String { return "\(contactName())\(title())\(place())" }
	
	init(contactName: String, title: String, place: String)
	{
		_contactName = contactName
		_title = title
		_place = place
	}
	
	func contactName() -> String { return (_contactName == nil ? "" : "<ContactName>\(_contactName!)</ContactName>") }
	func title() -> String { return (_title == nil ? "" : "<Title>\(_title!)</Title>") }
	func place() -> String { return (_place == nil ? "" : "<Place>\(_place!)</Place>") }
}

final class RadioactivityDetail : CustomStringConvertible
{
	fileprivate let _transportIndex: Decimal?
	fileprivate let _surfaceReading: Decimal?
	fileprivate let _criticalitySafetyIndex: Decimal?
	fileprivate let _dimensions: Dimensions?
	
	var description: String { return "\(transportIndex())\(surfaceReading())\(criticalitySafetyIndex())\(dimensions())" }
	
	init(transportIndex: Decimal, surfaceReading: Decimal, criticalitySafetyIndex: Decimal, dimensions: Dimensions)
	{
		_transportIndex = transportIndex
		_surfaceReading = surfaceReading
		_criticalitySafetyIndex = criticalitySafetyIndex
		_dimensions = dimensions
	}
	
	func transportIndex() -> String { return (_transportIndex == nil ? "" : "<TransportIndex>\(_transportIndex!)</TransportIndex>") }
	func surfaceReading() -> String { return (_surfaceReading == nil ? "" : "<SurfaceReading>\(_surfaceReading!)</SurfaceReading>") }
	func criticalitySafetyIndex() -> String { return (_criticalitySafetyIndex == nil ? "" : "<CriticalitySafetyIndex>\(_criticalitySafetyIndex!)</CriticalitySafetyIndex>") }
	func dimensions() -> String { return (_dimensions == nil ? "" : "<Dimensions>\(_dimensions!)</Dimensions>") }
}

final class Dimensions : CustomStringConvertible
{
	fileprivate let _length: Int?
	fileprivate let _width: Int?
	fileprivate let _height: Int?
	fileprivate let _units: LinearUnits?
	
	var description: String { return "\(length())\(width())\(height())\(units())" }
	
	init(length: Int?, width: Int?, height: Int?, units: LinearUnits?)
	{
		_length = length
		_width = width
		_height = height
		_units = units
	}
	
	func length() -> String { return (_length == nil ? "" : "<Length>\(_length!)</Length>") }
	func width() -> String { return (_width == nil ? "" : "<Width>\(_width!)</Width>") }
	func height() -> String { return (_height == nil ? "" : "<Height>\(_height!)</Height>") }
	func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
}

final class CustomerReference : CustomStringConvertible
{
	fileprivate let _customerReferenceType: CustomerReferenceType?
	fileprivate let _value: String?
	
	var description: String { return "\(customerReferenceType())\(value())" }
	
	init(customerReferenceType: CustomerReferenceType, value: String)
	{
		_customerReferenceType = customerReferenceType
		_value = value
	}
	
	func customerReferenceType() -> String { return (_customerReferenceType == nil ? "" : "<CustomerReferenceType>\(_customerReferenceType!)</CustomerReferenceType>") }
	func value() -> String { return (_value == nil ? "" : "<Value>\(_value!)</Value>") }
}

final class PackageSpecialServicesRequested : CustomStringConvertible
{
	let _specialServiceTypes: [PackageSpecialServiceType]
	let _codDetail: CodDetail?
	let _dangerousGoodsDetail: DangerousGoodsDetail?
	let _dryIceWeight: Weight?
	let _signatureOptionDetail: SignatureOptionDetail?
	let _priorityAlertDetail: PriorityAlertDetail?
	let _alcoholDetail: AlcoholDetail?
	
	var description: String { return "\(specialServiceTypes())\(codDetail())\(dangerousGoodsDetail())\(dryIceWeight())\(signatureOptionDetail())\(priorityAlertDetail())\(alcoholDetail())" }
	
	init(specialServiceTypes: [PackageSpecialServiceType], codDetail: CodDetail?, dangerousGoodsDetail: DangerousGoodsDetail?, dryIceWeight: Weight?, signatureOptionDetail: SignatureOptionDetail?, priorityAlertDetail: PriorityAlertDetail?, alcoholDetail: AlcoholDetail?)
	{
		_specialServiceTypes = specialServiceTypes
		_codDetail = codDetail
		_dangerousGoodsDetail = dangerousGoodsDetail
		_dryIceWeight = dryIceWeight
		_signatureOptionDetail = signatureOptionDetail
		_priorityAlertDetail = priorityAlertDetail
		_alcoholDetail = alcoholDetail
	}
	
	fileprivate func specialServiceTypes() -> String { return "\((_specialServiceTypes.map{ "<SpecialServiceTypes>\($0)</SpecialServiceTypes>" } as [String]).joined())" }
	fileprivate func codDetail() -> String { return (_codDetail == nil ? "" : "<CodDetail>\(_codDetail!)</CodDetail>") }
	fileprivate func dangerousGoodsDetail() -> String { return (_dangerousGoodsDetail == nil ? "" : "<DangerousGoodsDetail>\(_dangerousGoodsDetail!)</DangerousGoodsDetail>") }
	fileprivate func dryIceWeight() -> String { return (_dryIceWeight == nil ? "" : "<DryIceWeight>\(_dryIceWeight!)</DryIceWeight>") }
	fileprivate func signatureOptionDetail() -> String { return (_signatureOptionDetail == nil ? "" : "<SignatureOptionDetail>\(_signatureOptionDetail!)</SignatureOptionDetail>") }
	fileprivate func priorityAlertDetail() -> String { return (_priorityAlertDetail == nil ? "" : "<PriorityAlertDetail>\(_priorityAlertDetail!)</PriorityAlertDetail>") }
	fileprivate func alcoholDetail() -> String { return (_alcoholDetail == nil ? "" : "<AlcoholDetail>\(_alcoholDetail!)</AlcoholDetail>") }
}

final class SignatureOptionDetail : CustomStringConvertible
{
	let _optionType: SignatureOptionType?
	let _signatureReleaseNumber: String?
	
	var description: String { return "\(optionType())\(signatureReleaseNumber())" }
	
	init(optionType: SignatureOptionType?)
	{
		_optionType = optionType
		_signatureReleaseNumber = nil
	}
	
	init(optionType: SignatureOptionType?, signatureReleaseNumber: String?)
	{
		_optionType = optionType
		_signatureReleaseNumber = signatureReleaseNumber
	}
	
	fileprivate func optionType() -> String { return (_optionType == nil ? "" : "<OptionType>\(_optionType!)</OptionType>") }
	fileprivate func signatureReleaseNumber() -> String { return (_signatureReleaseNumber == nil ? "" : "<SignatureReleaseNumber>\(_signatureReleaseNumber!)</SignatureReleaseNumber>") }
}

final class CodDetail : CustomStringConvertible
{
	let _codCollectionAmount: Money?
	let _addTransportationChargesDetail: CodAddTransportationChargesDetail?
	let _collectionType: CodCollectionType?
	let _codRecipient: Party?
	let _financialInstitutionContactAndAddress: ContactAndAddress?
	let _remitToName: String?
	let _referenceIndicator: CodReturnReferenceIndicatorType?
	let _returnTrackingId: TrackingId?
	
	var description: String { return "\(codCollectionAmount())\(addTransportationChargesDetail())\(collectionType())\(codRecipient())\(financialInstitutionContactAndAddress())\(remitToName())\(referenceIndicator())\(returnTrackingId())" }
	
	init(collectionType: CodCollectionType?)
	{
		_codCollectionAmount = nil
		_addTransportationChargesDetail = nil
		_collectionType = collectionType
		_codRecipient = nil
		_financialInstitutionContactAndAddress = nil
		_remitToName = nil
		_referenceIndicator = nil
		_returnTrackingId = nil
	}
	
	fileprivate func codCollectionAmount() -> String { return (_codCollectionAmount == nil ? "" : "<CodCollectionAmount>\(_codCollectionAmount!)</CodCollectionAmount>") }
	fileprivate func addTransportationChargesDetail() -> String { return (_addTransportationChargesDetail == nil ? "" : "<AddTransportationChargesDetail>\(_addTransportationChargesDetail!)</AddTransportationChargesDetail>") }
	fileprivate func collectionType() -> String { return (_collectionType == nil ? "" : "<CollectionType>\(_collectionType!)</CollectionType>") }
	fileprivate func codRecipient() -> String { return (_codRecipient == nil ? "" : "<CodRecipient>\(_codRecipient!)</CodRecipient>") }
	fileprivate func financialInstitutionContactAndAddress() -> String { return (_financialInstitutionContactAndAddress == nil ? "" : "<FinancialInstitutionContactAndAddress>\(_financialInstitutionContactAndAddress!)</FinancialInstitutionContactAndAddress>") }
	fileprivate func remitToName() -> String { return (_remitToName == nil ? "" : "<RemitToName>\(_remitToName!)</RemitToName>") }
	fileprivate func referenceIndicator() -> String { return (_referenceIndicator == nil ? "" : "<ReferenceIndicator>\(_referenceIndicator!)</ReferenceIndicator>") }
	fileprivate func returnTrackingId() -> String { return (_returnTrackingId == nil ? "" : "<ReturnTrackingId>\(_returnTrackingId!)</ReturnTrackingId>") }
}

final class CodAddTransportationChargesDetail : CustomStringConvertible
{
	fileprivate let _rateTypeBasis: RateTypeBasisType?
	fileprivate let _chargeBasis: CodAddTransportationChargeBasisType?
	fileprivate let _chargeBasisLevel: ChargeBasisLevelType?
	
	var description: String { return "\(rateTypeBasis())\(chargeBasis())\(chargeBasisLevel())" }
	
	init(rateTypeBasis: RateTypeBasisType, chargeBasis: CodAddTransportationChargeBasisType, chargeBasisLevel: ChargeBasisLevelType)
	{
		_rateTypeBasis = rateTypeBasis
		_chargeBasis = chargeBasis
		_chargeBasisLevel = chargeBasisLevel
	}
	
	func rateTypeBasis() -> String { return (_rateTypeBasis == nil ? "" : "<RateTypeBasis>\(_rateTypeBasis!)</RateTypeBasis>") }
	func chargeBasis() -> String { return (_chargeBasis == nil ? "" : "<ChargeBasis>\(_chargeBasis!)</ChargeBasis>") }
	func chargeBasisLevel() -> String { return (_chargeBasisLevel == nil ? "" : "<ChargeBasisLevel>\(_chargeBasisLevel!)</ChargeBasisLevel>") }
}

final class PriorityAlertDetail : CustomStringConvertible
{
	let _enhancementTypes: PriorityAlertEnhancementType?
	let _content: String?
	
	var description: String { return "\(enhancementTypes())\(content())" }
	
	init(enhancementTypes: PriorityAlertEnhancementType?)
	{
		_enhancementTypes = enhancementTypes
		_content = nil
	}
	
	fileprivate func enhancementTypes() -> String { return (_enhancementTypes == nil ? "" : "<EnhancementTypes>\(_enhancementTypes!)</EnhancementTypes>") }
	fileprivate func content() -> String { return (_content == nil ? "" : "<Content>\(_content!)</Content>") }
}

final class AlcoholDetail : CustomStringConvertible
{
	let _recipientType: AlcoholRecipientType?
	
	var description: String { return "\(recipientType())" }
	
	init(recipientType: AlcoholRecipientType?)
	{
		_recipientType = recipientType
	}
	
	fileprivate func recipientType() -> String { return (_recipientType == nil ? "" : "<RecipientType>\(_recipientType!)</RecipientType>") }
}

struct ContentRecord : CustomStringConvertible
{
	fileprivate let _partNumber: String?
	fileprivate let _itemNumber: String?
	fileprivate let _receivedQuantity: Int?
	
	var description: String { return "\(partNumber())\(itemNumber())\(receivedQuantity())" }
	
	init(partNumber: String?, itemNumber: String?, receivedQuantity: Int?)
	{
		_partNumber = partNumber
		_itemNumber = itemNumber
		_receivedQuantity = receivedQuantity
	}
	
	func partNumber() -> String { return (_partNumber == nil ? "" : "<PartNumber>\(_partNumber!)</PartNumber>") }
	func itemNumber() -> String { return (_itemNumber == nil ? "" : "<ItemNumber>\(_itemNumber!)</ItemNumber>") }
	func receivedQuantity() -> String { return (_receivedQuantity == nil ? "" : "<ReceivedQuantity>\(_receivedQuantity!)</ReceivedQuantity>") }
}

final class ServiceSubOptionDetail : CustomStringConvertible
{
	fileprivate let _freightGuarantee: FreightGuaranteeType?
	fileprivate let _smartPostHubId: String?
	fileprivate let _smartPostIndicia: SmartPostIndiciaType?
	
	var description: String { return "\(freightGuarantee())\(smartPostHubId())\(smartPostIndicia())" }
	
	init(freightGuarantee: FreightGuaranteeType?, smartPostHubId: String?, smartPostIndicia: SmartPostIndiciaType?)
	{
		_freightGuarantee = freightGuarantee
		_smartPostHubId = smartPostHubId
		_smartPostIndicia = smartPostIndicia
	}
	
	func freightGuarantee() -> String { return (_freightGuarantee == nil ? "" : "<FreightGuarantee>\(_freightGuarantee!)</FreightGuarantee>") }
	func smartPostHubId() -> String { return (_smartPostHubId == nil ? "" : "<SmartPostHubId>\(_smartPostHubId!)</SmartPostHubId>") }
	func smartPostIndicia() -> String { return (_smartPostIndicia == nil ? "" : "<SmartPostIndicia>\(_smartPostIndicia!)</SmartPostIndicia>") }
}

struct CleansedAddressAndLocationDetail
{
	fileprivate let _countryCode: String?
	fileprivate let _stateOrProvinceCode: String?
	fileprivate let _postalCode: String?
	fileprivate let _serviceArea: String?
	fileprivate let _locationId: String?
	fileprivate let _locationNumber: String?
	fileprivate let _airportId: String?
	
	init(countryCode: String?, stateOrProvinceCode: String?, postalCode: String?, serviceArea: String?, locationId: String?, locationNumber: String?, airportId: String?)
	{
		_countryCode = countryCode
		_stateOrProvinceCode = stateOrProvinceCode
		_postalCode = postalCode
		_serviceArea = serviceArea
		_locationId = locationId
		_locationNumber = locationNumber
		_airportId = airportId
	}
}

final class CommitDetail : CustomStringConvertible
{
	fileprivate let _index: Int
	fileprivate let _stack: Stack<ValuePath>
	
	var description: String { return "RateReply|RatReplyDetails|CommitDetails" }
	
	init(_ index: Int, _ stack: Stack<ValuePath>)
	{
		_index = index
		_stack = stack
	}
	
	func commodityName() -> String? { return _stack.find("RateReply|RateReplyDetails|CommitDetails").getValue(service: (serviceType()?.rawValue)!, value: "CommodityName") }
	func serviceType() -> ServiceType? { return ServiceType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails|ServiceType")[safe: _index]?.value) }
	func appliedOptions() -> ServiceOptionType? { return ServiceOptionType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails").getValue(service: (serviceType()?.rawValue)!, value: "AppliedOptions")) }
	func appliedSubOptions() -> ServiceSubOptionDetail?
	{
		return ServiceSubOptionDetail(
			freightGuarantee: FreightGuaranteeType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails|AppliedSubOptions").getValue(service: (serviceType()?.rawValue)!, value: "FreightGuarantee")),
			smartPostHubId: _stack.find("RateReply|RateReplyDetails|CommitDetails|AppliedSubOptions").getValue(service: (serviceType()?.rawValue)!, value: "SmartPostHubId"),
			smartPostIndicia: SmartPostIndiciaType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails|AppliedSubOptions").getValue(service: (serviceType()?.rawValue)!, value: "SmartPostIndicia"))
		)
	}
	func derivedShipmentSignatureOption() -> SignatureOptionDetail?
	{
		return SignatureOptionDetail(
			optionType: SignatureOptionType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedShipmentSignatureOption|OptionType")[safe: _index]?.value),
			signatureReleaseNumber: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedShipmentSignatureOption|SignatureReleaseNumber")[safe: _index]?.value
		)
	}
	func derivedPackageSignatureOptions() -> SignatureOptionDetail?
	{
		return SignatureOptionDetail(
			optionType: SignatureOptionType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedPackageSignatureOptions|OptionType")[safe: _index]?.value),
			signatureReleaseNumber: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedPackageSignatureOptions|SignatureReleaseNumber")[safe: _index]?.value
		)
	}
	func derivedOriginDetail() -> CleansedAddressAndLocationDetail?
	{
		return CleansedAddressAndLocationDetail(
			countryCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedOriginDetail").getValue(service: (serviceType()?.rawValue)!, value: "CountryCode"),
			stateOrProvinceCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedOriginDetail").getValue(service: (serviceType()?.rawValue)!, value: "StateOrProvinceCode"),
			postalCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedOriginDetail").getValue(service: (serviceType()?.rawValue)!, value: "PostalCode"),
			serviceArea: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedOriginDetail").getValue(service: (serviceType()?.rawValue)!, value: "ServiceArea"),
			locationId: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedOriginDetail").getValue(service: (serviceType()?.rawValue)!, value: "LocationId"),
			locationNumber: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedOriginDetail").getValue(service: (serviceType()?.rawValue)!, value: "LocationNumber"),
			airportId: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedOriginDetail").getValue(service: (serviceType()?.rawValue)!, value: "AirportId")
		)
	}
	func derivedDestinationDetail() -> CleansedAddressAndLocationDetail?
	{
		return CleansedAddressAndLocationDetail(
			countryCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedDestinationDetail").getValue(service: (serviceType()?.rawValue)!, value: "CountryCode"),
			stateOrProvinceCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedDestinationDetail").getValue(service: (serviceType()?.rawValue)!, value: "StateOrProvinceCode"),
			postalCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedDestinationDetail").getValue(service: (serviceType()?.rawValue)!, value: "PostalCode"),
			serviceArea: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedDestinationDetail").getValue(service: (serviceType()?.rawValue)!, value: "ServiceArea"),
			locationId: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedDestinationDetail").getValue(service: (serviceType()?.rawValue)!, value: "LcationId"),
			locationNumber: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedDestinationDetail").getValue(service: (serviceType()?.rawValue)!, value: "LocationNumber"),
			airportId: _stack.find("RateReply|RateReplyDetails|CommitDetails|DerivedDestinationDetail").getValue(service: (serviceType()?.rawValue)!, value: "AirportId")
		)
	}
	func commitTimestamp() -> Date? { return _stack.find("RateReply|RateReplyDetails|CommitDetails").getValue(service: (serviceType()?.rawValue)!, value: "CommitTimestamp")?.toDate() }
	func dayOfWeek() -> DayOfWeekType? { return DayOfWeekType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails").getValue(service: (serviceType()?.rawValue)!, value: "DayOfWeek")) }
	func transitTime() -> TransitTimeType? { return TransitTimeType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails").getValue(service: (serviceType()?.rawValue)!, value: "TransitTime")) }
	func maximumTransitTime() -> TransitTimeType? { return TransitTimeType(rawValue: _stack.find("RateReply|RateReplyDetails|CommitDetails").getValue(service: (serviceType()?.rawValue)!, value: "MaximumTransitTime")) }
	func destinationServiceArea() -> String? { return _stack.find("RateReply|RateReplyDetails|CommitDetails").getValue(service: (serviceType()?.rawValue)!, value: "DestinationServiceArea") }
	func brokerAddress() -> Address?
	{
		return Address(
			streetLines: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|StreetLines")[safe: _index]?.value,
			city: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|City")[safe: _index]?.value,
			stateOrProvinceCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|StateOrProvinceCode")[safe: _index]?.value,
			postalCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|PostalCode")[safe: _index]?.value,
			urbanizationCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|UrbanizationCode")[safe: _index]?.value,
			countryCode: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|CountryCode")[safe: _index]?.value,
			countryName: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|CountryName")[safe: _index]?.value,
			residential: _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerAddress|Residential")[safe: _index]?.value == ""
		)
	}
	func brokerLocationId() -> String? { return _stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerLocationId")[safe: _index]?.value }
	func brokerCommitTimestamp() -> Date? { return nil } //_stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerCommitTimestamp")[safe: _index]?.value
	func brokerCommitDayOfWeek() -> DayOfWeekType? { return nil } //DayOfWeekType(rawValue: (_stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerCommitDayOfWeek")[safe: _index]?.value)!)
	func brokerToDestinationDays() -> Int? { return nil } //Int((_stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerToDestinationDays")[safe: _index]?.value)!),
	func proofOfDeliveryDate() -> Date? { return nil }
	func proofOfDeliveryDayOfWeek() -> DayOfWeekType? { return nil }
	func commitMessages() -> fNotification? { return nil }
	func deliveryMessages() -> String? { return nil}
	func delayDetails() -> DelayDetail? { return nil }
	func documentContent() -> InternationalDocumentContentType? { return InternationalDocumentContentType(rawValue: (_stack.find("RateReply|RateReplyDetails|CommitDetails|DocumentContent")[safe: _index]?.value)!) }
	func requiredDocuments() -> RequiredShippingDocumentType? { return nil }
	func freightCommitDetail() -> FreightCommitDetail? { return nil }
}

final class DelayDetail
{
	fileprivate let _date: Date?
	fileprivate let _dayOfWeek: DayOfWeekType?
	fileprivate let _level: DelayLevelType?
	fileprivate let _point: DelayPointType?
	fileprivate let _type: CommitmentDelayType?
	fileprivate let _description: String?
	
	init(date: Date?, dayOfWeek: DayOfWeekType?, level: DelayLevelType?, point: DelayPointType?, type: CommitmentDelayType?, description: String?)
	{
		_date = date
		_dayOfWeek = dayOfWeek
		_level = level
		_point = point
		_type = type
		_description = description
	}
}

final class FreightCommitDetail
{
	fileprivate let _originDetail: FreightServiceCenterDetail?
	fileprivate let _destinationDetail: FreightServiceCenterDetail?
	fileprivate let _totalDistance: Distance?
	
	init(originDetail: FreightServiceCenterDetail?, destinationDetail: FreightServiceCenterDetail?, totalDistance: Distance?)
	{
		_originDetail = originDetail
		_destinationDetail = destinationDetail
		_totalDistance = totalDistance
	}
}

final class FreightServiceCenterDetail
{
	fileprivate let _interlineCarrierCode: String?
	fileprivate let _interlineCarrierName: String?
	fileprivate let _additionalDays: Int?
	fileprivate let _localService: ServiceType?
	fileprivate let _localDistance: Distance?
	fileprivate let _localDuration: String?
	fileprivate let _localServiceScheduling: FreightServiceSchedulingType?
	fileprivate let _limitedServiceDays: DayOfWeekType?
	fileprivate let _gatewayLocationId: String?
	fileprivate let _location: String?
	fileprivate let _contactAndAddress: ContactAndAddress?
	
	init()
	{
		_interlineCarrierCode = nil
		_interlineCarrierName = nil
		_additionalDays = nil
		_localService = nil
		_localDistance = nil
		_localDuration = nil
		_localServiceScheduling = nil
		_limitedServiceDays = nil
		_gatewayLocationId = nil
		_location = nil
		_contactAndAddress = nil
	}
}

final class Distance
{
	fileprivate let _value: Decimal?
	fileprivate let _units: DistanceUnits?
	
	init(value: Decimal?, units: DistanceUnits?)
	{
		_value = value
		_units = units
	}
}

struct Money : CustomStringConvertible
{
	fileprivate let _currency: String?
	fileprivate let _amount: Decimal?
	
	var description: String { return "\(currency())\(amount())" }
	
	init(currency: String?, amount: Decimal?)
	{
		_currency = currency
		_amount = amount
	}
	
	func currency() -> String { return (_currency == nil ? "" : "<Currency>\(_currency!)</Currency>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
}

struct CurrencyExchangeRate : CustomStringConvertible
{
	fileprivate let _fromCurrency: String?
	fileprivate let _intoCurrency: String?
	fileprivate let _rate: Decimal?
	
	var description: String { return "\(fromCurrency())\(intoCurrency())\(rate())" }
	
	init(fromCurrency: String, intoCurrency: String, rate: Decimal)
	{
		_fromCurrency = fromCurrency
		_intoCurrency = intoCurrency
		_rate = rate
	}
	
	func fromCurrency() -> String { return (_fromCurrency == nil ? "" : "<FromCurrency>\(_fromCurrency!)</FromCurrency>") }
	func intoCurrency() -> String { return (_intoCurrency == nil ? "" : "<IntoCurrency>\(_intoCurrency!)</IntoCurrency>") }
	func rate() -> String { return (_rate == nil ? "" : "<Rate>\(_rate!)</Rate>") }
}

final class FreightRateDetail : CustomStringConvertible
{
	fileprivate let _quoteNumber: String?
	fileprivate let _quoteType: FreightRateQuoteType?
	fileprivate let _baseChargeCalculation: FreightBaseChargeCalculationType?
	fileprivate let _baseCharges: FreightBaseCharge?
	fileprivate let _notations: FreightRateNotation?
	
	var description: String { return "\(quoteNumber())\(quoteType())\(baseChargeCalculation())\(baseCharges())\(notations())" }
	
	init(quoteNumber: String, quoteType: FreightRateQuoteType, baseChargeCalculation: FreightBaseChargeCalculationType, baseCharges: FreightBaseCharge, notations: FreightRateNotation)
	{
		_quoteNumber = quoteNumber
		_quoteType = quoteType
		_baseChargeCalculation = baseChargeCalculation
		_baseCharges = baseCharges
		_notations = notations
	}
	
	func quoteNumber() -> String { return (_quoteNumber == nil ? "" : "<QuoteNumber>\(_quoteNumber!)</QuoteNumber>") }
	func quoteType() -> String { return (_quoteType == nil ? "" : "<QuoteType>\(_quoteType!)</QuoteType>") }
	func baseChargeCalculation() -> String { return (_baseChargeCalculation == nil ? "" : "<BaseChargeCalculation>\(_baseChargeCalculation!)</BaseChargeCalculation>") }
	func baseCharges() -> String { return (_baseCharges == nil ? "" : "<BaseCharges>\(_baseCharges!)</BaseCharges>") }
	func notations() -> String { return (_notations == nil ? "" : "<Notations>\(_notations!)</Notations>") }
}

final class FreightBaseCharge : CustomStringConvertible
{
	fileprivate let _freightClass: FreightClassType?
	fileprivate let _ratedAsClass: FreightClassType?
	fileprivate let _nmfcCode: String?
	fileprivate let _description: String?
	fileprivate let _weight: Weight?
	fileprivate let _chargeRate: Money?
	fileprivate let _chargeBasis: FreightChargeBasisType?
	fileprivate let _extendedAmount: Money?
	
	var description: String { return "\(freightClass())\(ratedAsClass())\(nmfcCode())\(description_())\(weight())\(chargeRate())\(chargeBasis())\(extendedAmount())" }
	
	init(freightClass: FreightClassType, ratedAsClass: FreightClassType, nmfcCode: String, description: String, weight: Weight, chargeRate: Money, chargeBasis: FreightChargeBasisType, extendedAmount: Money)
	{
		_freightClass = freightClass
		_ratedAsClass = ratedAsClass
		_nmfcCode = nmfcCode
		_description = description
		_weight = weight
		_chargeRate = chargeRate
		_chargeBasis = chargeBasis
		_extendedAmount = extendedAmount
	}
	
	func freightClass() -> String { return (_freightClass == nil ? "" : "<FreightClass>\(_freightClass!)</FreightClass>") }
	func ratedAsClass() -> String { return (_ratedAsClass == nil ? "" : "<RatedAsClass>\(_ratedAsClass!)</RatedAsClass>") }
	func nmfcCode() -> String { return (_nmfcCode == nil ? "" : "<NmfcCode>\(_nmfcCode!)</NmfcCode>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func weight() -> String { return (_weight == nil ? "" : "<Weight>\(_weight!)</Weight>") }
	func chargeRate() -> String { return (_chargeRate == nil ? "" : "<ChargeRate>\(_chargeRate!)</ChargeRate>") }
	func chargeBasis() -> String { return (_chargeBasis == nil ? "" : "<ChargeBasis>\(_chargeBasis!)</ChargeBasis>") }
	func extendedAmount() -> String { return (_extendedAmount == nil ? "" : "<ExtendedAmount>\(_extendedAmount!)</ExtendedAmount>") }
}

struct FreightRateNotation : CustomStringConvertible
{
	fileprivate let _code: String?
	fileprivate let _description: String?
	
	var description: String { return "\(code())\(description_())" }
	
	init(code: String, description: String)
	{
		_code = code
		_description = description
	}
	
	func code() -> String { return (_code == nil ? "" : "<Code>\(_code!)</Code>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
}

final class RateDiscount : CustomStringConvertible
{
	fileprivate let _rateDiscountType: RateDiscountType?
	fileprivate let _description: String?
	fileprivate let _amount: Money?
	fileprivate let _percent: Decimal?
	
	var description: String { return "\(rateDiscountType())\(description_())\(amount())\(percent())" }
	
	init(rateDiscountType: RateDiscountType, description: String, amount: Money, percent: Decimal)
	{
		_rateDiscountType = rateDiscountType
		_description = description
		_amount = amount
		_percent = percent
	}
	
	func rateDiscountType() -> String { return (_rateDiscountType == nil ? "" : "<RateDiscountType>\(_rateDiscountType!)</RateDiscountType>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
	func percent() -> String { return (_percent == nil ? "" : "<Percent>\(_percent!)</Percent>") }
}

final class Rebate : CustomStringConvertible
{
	fileprivate let _rebateType: RebateType?
	fileprivate let _description: String?
	fileprivate let _amount: Money?
	fileprivate let _percent: Decimal?
	
	var description: String { return "\(rebateType())\(description_())\(amount())\(percent())" }
	
	init(rebateType: RebateType, description: String, amount: Money, percent: Decimal)
	{
		_rebateType = rebateType
		_description = description
		_amount = amount
		_percent = percent
	}
	
	func rebateType() -> String { return (_rebateType == nil ? "" : "<RebateType>\(_rebateType!)</RebateType>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
	func percent() -> String { return (_percent == nil ? "" : "<Percent>\(_percent!)</Percent>") }
}

final class Surcharge : CustomStringConvertible
{
	fileprivate let _surchargeType: SurchargeType?
	fileprivate let _level: SurchargeLevelType?
	fileprivate let _description: String?
	fileprivate let _amount: Money?
	
	var description: String { return "\(surchargeType())\(level())\(description_())\(amount())" }
	
	init(surchargeType: SurchargeType, level: SurchargeLevelType, description: String, amount: Money)
	{
		_surchargeType = surchargeType
		_level = level
		_description = description
		_amount = amount
	}
	
	func surchargeType() -> String { return (_surchargeType == nil ? "" : "<SurchargeType>\(_surchargeType!)</SurchargeType>") }
	func level() -> String { return (_level == nil ? "" : "<Level>\(_level!)</Level>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
}

final class Tax : CustomStringConvertible
{
	fileprivate let _taxType: TaxType?
	fileprivate let _description: String?
	fileprivate let _amount: Money?
	
	var description: String { return "\(taxType())\(description_())\(amount())" }
	
	init(taxType: TaxType, description: String, amount: Money)
	{
		_taxType = taxType
		_description = description
		_amount = amount
	}
	
	func taxType() -> String { return (_taxType == nil ? "" : "<TaxType>\(_taxType!)</TaxType>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
}

final class EdtCommodityTax : CustomStringConvertible
{
	fileprivate let _harmonizedCode: String?
	fileprivate let _taxes: EdtTaxDetail?
	
	var description: String { return "\(harmonizedCode())\(taxes())" }
	
	init(harmonizedCode: String, taxes: EdtTaxDetail)
	{
		_harmonizedCode = harmonizedCode
		_taxes = taxes
	}
	
	func harmonizedCode() -> String { return (_harmonizedCode == nil ? "" : "<HarmonizedCode>\(_harmonizedCode!)</HarmonizedCode>") }
	func taxes() -> String { return (_taxes == nil ? "" : "<Taxes>\(_taxes!)</Taxes>") }
}

final class EdtTaxDetail : CustomStringConvertible
{
	fileprivate let _taxType: EdtTaxType?
	fileprivate let _effectiveDate: Date?
	fileprivate let _name: String?
	fileprivate let _taxableValue: Money?
	fileprivate let _description: String?
	fileprivate let _formula: String?
	fileprivate let _amount: Money?
	
	var description: String { return "\(taxType())\(effectiveDate())\(name())\(taxableValue())\(description_())\(formula())\(amount())" }
	
	init(taxType: EdtTaxType, effectiveDate: Date, name: String, taxableValue: Money, description: String, formula: String, amount: Money)
	{
		_taxType = taxType
		_effectiveDate = effectiveDate
		_name = name
		_taxableValue = taxableValue
		_description = description
		_formula = formula
		_amount = amount
	}
	
	func taxType() -> String { return (_taxType == nil ? "" : "<TaxType>\(_taxType!)</TaxType>") }
	func effectiveDate() -> String { return (_effectiveDate == nil ? "" : "<EffectiveDate>\(_effectiveDate!)</EffectiveDate>") }
	func name() -> String { return (_name == nil ? "" : "<Name>\(_name!)</Name>") }
	func taxableValue() -> String { return (_taxableValue == nil ? "" : "<TaxableValue>\(_taxableValue!)</TaxableValue>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func formula() -> String { return (_formula == nil ? "" : "<Formula>\(_formula!)</Formula>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
}

final class AncillaryFeeAndTax : CustomStringConvertible
{
	fileprivate let _type: AncillaryFeeAndTaxType?
	fileprivate let _description: String?
	fileprivate let _amount: Money?
	
	var description: String { return "\(type())\(description_())\(amount())" }
	
	init(type: AncillaryFeeAndTaxType, description: String, amount: Money)
	{
		_type = type
		_description = description
		_amount = amount
	}
	
	func type() -> String { return (_type == nil ? "" : "<Type>\(_type!)</Type>") }
	func description_() -> String { return (_description == nil ? "" : "<Description>\(_description!)</Description>") }
	func amount() -> String { return (_amount == nil ? "" : "<Amount>\(_amount!)</Amount>") }
}

final class VariableHandlingCharges : CustomStringConvertible
{
	fileprivate let _variableHandlingCharge: Money?
	fileprivate let _fixedVariableHandlingCharge: Money?
	fileprivate let _percentVariableHandlingCharge: Money?
	fileprivate let _totalCustomerCharge: Money?
	
	var description: String { return "\(variableHandlingCharge())\(fixedVariableHandlingCharge())\(percentVariableHandlingCharge())\(totalCustomerCharge())" }
	
	init(variableHandlingCharge: Money, fixedVariableHandlingCharge: Money, percentVariableHandlingCharge: Money, totalCustomerCharge: Money)
	{
		_variableHandlingCharge = variableHandlingCharge
		_fixedVariableHandlingCharge = fixedVariableHandlingCharge
		_percentVariableHandlingCharge = percentVariableHandlingCharge
		_totalCustomerCharge = totalCustomerCharge
	}
	
	func variableHandlingCharge() -> String { return (_variableHandlingCharge == nil ? "" : "<VariableHandlingCharge>\(_variableHandlingCharge!)</VariableHandlingCharge>") }
	func fixedVariableHandlingCharge() -> String { return (_fixedVariableHandlingCharge == nil ? "" : "<FixedVariableHandlingCharge>\(_fixedVariableHandlingCharge!)</FixedVariableHandlingCharge>") }
	func percentVariableHandlingCharge() -> String { return (_percentVariableHandlingCharge == nil ? "" : "<PercentVariableHandlingCharge>\(_percentVariableHandlingCharge!)</PercentVariableHandlingCharge>") }
	func totalCustomerCharge() -> String { return (_totalCustomerCharge == nil ? "" : "<TotalCustomerCharge>\(_totalCustomerCharge!)</TotalCustomerCharge>") }
}

final class TrackingId : CustomStringConvertible
{
	fileprivate let _trackingIdType: TrackingIdType?
	fileprivate let _formId: String?
	fileprivate let _trackingNumber: String?
	
	var description: String { return "\(trackingIdType())\(formId())\(trackingNumber())" }
	
	init(trackingIdType: TrackingIdType, formId: String, trackingNumber: String)
	{
		_trackingIdType = trackingIdType
		_formId = formId
		_trackingNumber = trackingNumber
	}
	
	func trackingIdType() -> String { return (_trackingIdType == nil ? "" : "<TrackingIdType>\(_trackingIdType!)</TrackingIdType>") }
	func formId() -> String { return (_formId == nil ? "" : "<FormId>\(_formId!)</FormId>") }
	func trackingNumber() -> String { return (_trackingNumber == nil ? "" : "<TrackingNumber>\(_trackingNumber!)</TrackingNumber>") }
}

final class Weight : CustomStringConvertible
{
	let _units: WeightUnits?
	let _value: Float?
	
	var description: String { return "\(units())\(value())" }
	
	init(units: WeightUnits, value: Float)
	{
		_units = units
		_value = value
	}
	
	fileprivate func units() -> String { return (_units == nil ? "" : "<Units>\(_units!)</Units>") }
	fileprivate func value() -> String { return (_value == nil ? "" : "<Value>\(_value!)</Value>") }
}

func formatDate(_ date: Date) -> String
{
	let dateFormatter = DateFormatter()
	
	dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
	
	return dateFormatter.string(from: date as Date)
}

