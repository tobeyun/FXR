//
//  LocationsService.swift
//  FXR
//
//  Created by Tobey Unruh on 12/15/2018.
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
                                        "xmlns=\"http://fedex.com/ws/locs/v9\"><SOAP-ENV:Body>\(_message)</SOAP-ENV:Body></SOAP-ENV:Envelope>" }
    
    init(_ message: String)
    {
        _message = message
    }
}

struct SearchLocationsRequest : CustomStringConvertible
{
    fileprivate let _webAuthenticationDetail: WebAuthenticationDetail
    fileprivate let _clientDetail: ClientDetail
    fileprivate let _transactionDetail: TransactionDetail?
    fileprivate let _version: VersionId
    fileprivate let _effectiveDate: Date?
    fileprivate let _locationsSearchCritierion: LocationsSearchCriteriaType
    fileprivate let _shipperAccountNumber: String?
    fileprivate let _uniqueTrackingNumber: UniqueTrackingNumber
    fileprivate let _address: Address
    fileprivate let _phoneNumber: String?
    fileprivate let _geographicCoordinates: String?
    fileprivate let _multipleMatchesAction: MultipleMatchesActionType
    fileprivate let _sortDetail: LocationSortDetail
    fileprivate let _constraints: SearchLocationConstraints
    
    var description: String { return "\(SoapMessage("<\(type(of: self))>\(webAuthenticationDetail())\(clientDetail())\(transactionDetail())\(version())\(selectionDetails())\(transactionTimeOutValueInMilliseconds())\(processingOptions())</\(type(of: self))>"))" }
    
    init(webAuthenticationDetail: WebAuthenticationDetail,
         clientDetail: ClientDetail,
         transactionDetail: TransactionDetail?,
         effectiveDate: Date?,
         locationsSearchCriterion: LocationsSearchCriteriaType,
         shipperAccountNumber: String?,
         uniqueTrackingNumber: UniqueTrackingNumber,
         address: Address,
         phoneNumber: String?,
         geographicalCoordinates: String?,
         multipleMatchesAction: MultipleMatchesActionType,
         sortDetail: LocationSortDetail,
         constraints: SearchLocationConstraints)
    {
        _webAuthenticationDetail = webAuthenticationDetail
        _clientDetail = clientDetail
        _transactionDetail = transactionDetail
        _version = VersionId()
        _effectiveDate = effectiveDate
        _locationsSearchCritierion = locationsSearchCriterion
        _shipperAccountNumber = shipperAccountNumber
        _uniqueTrackingNumber = uniqueTrackingNumber
        _address = address
        _phoneNumber = phoneNumber
        _geographicCoordinates = geographicalCoordinates
        _multipleMatchesAction = multipleMatchesAction
        _sortDetail = sortDetail
        _constraints = constraints
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
    fileprivate let _serviceId: String = "locs"
    fileprivate let _major: Int = 9
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

struct UniqueTrackingNumber : CustomStringConvertible
{
    let _trackingNumber : String
    let _trackingNumberUniqueIdentifier : String
    let _shipDate : Date?
    
    var description: String { return "\(trackingNumber())\(trackingNumberUniqueIdentifier())\(shipDate())" }
   
    func trackingNumber() -> String { return "<TrackingNumber>\(_trackingNumber)</TrackingNumber>" }
    func trackingNumberUniqueIdentifier() -> String { return "<TrackingNumberUniqueIdentifier>\(_trackingNumberUniqueIdentifier)</TrackingNumberUniqueIdentifier>" }
    func shipDate() -> String { return (_shipDate == nil ? "" : "<ShipDate>\(formatDate(_shipDate!))</ShipDate>") }
}

struct LocationSortDetail : CustomStringConvertible
{
    let _criterion: LocationSortCriteriaType
    let _order: LocationSortOrderType
    
    var description: String { return "\(criterion())\(order())" }
    
    init(criterion: LocationSortCriteriaType, order: LocationSortOrderType)
    {
        _criterion = criterion
        _order = order
    }
    
    func criterion() -> String { return "<Criterion>\(_criterion)</Criterion>" }
    func order() -> String { return "<Order>\(_order)</Order>" }
}

struct SearchLocationConstraints : CustomStringConvertible
{
    let _radiusDistance: Distance
    let _dropOffTimeNeeded: Date?
    let _resultsFilters: LocationSearchFilterType
    let _supportedRedirectToHoldServices: SupportedRedirectToHoldServiceType
    let _requiredLocationAttributes: LocationAttributesType
    let _requiredLocationCapabilities: LocationCapabilityDetail
    let _shipmentDetail: LocationSupportedShipmentDetail
    let _resultsToSkip: UInt?
    let _resultsRequested: UInt?
    let _locationContentOptions: LocationContentOptionType
    let _locationTypesToInclude: FedExLocationType
    
    var description: String { return "\(radiusDistance())\(dropOffTimeNeeded())\(resultsFilters())\(supportedRedirectToHoldServices())\(requiredLocationAttributes())\(requiredLocationCapabilities())\(shipmentDetail())\(resultsToSkip())\(resultsRequested())\(locationContentOptions())\(locationTypesToInclude())" }
    
    init(radiusDistance: Distance, dropOffTimeNeeded: Date?, resultsFilters: LocationSearchFilterType, supportedRedirectsToHoldServices: SupportedRedirectToHoldServiceType, requiredLocationAttributes: LocationAttributesType, requiredLocationCapabilities: LocationCapabilityDetail, shipmentDetail: LocationSupportedShipmentDetail, resultsToSkip: UInt?, resultsRequested: UInt?, locationContentOptions: LocationContentOptionType, locationTypesToInclude: FedExLocationType)
    {
        _radiusDistance = radiusDistance
        _dropOffTimeNeeded = dropOffTimeNeeded
        _resultsFilters = resultsFilters
        _supportedRedirectToHoldServices = supportedRedirectsToHoldServices
        _requiredLocationAttributes = requiredLocationAttributes
        _requiredLocationCapabilities = requiredLocationCapabilities
        _shipmentDetail = shipmentDetail
        _resultsToSkip = resultsToSkip
        _resultsRequested = resultsRequested
        _locationContentOptions = locationContentOptions
        _locationTypesToInclude = locationTypesToInclude
    }
    
    func radiusDistance() -> String { return "<RadiusDistance>\(_radiusDistance)</RadiusDistance>" }
    func dropOffTimeNeeded() -> String { return "<DropOffTimeNeeded>\(_dropOffTimeNeeded)</DropOffTimeNeeded>" }
    func resultsFilters() -> String { return "<ResultsFilters>\(_resultsFilters)</ResultsFilters>" }
    func supportedRedirectToHoldServices() -> String { return "<SupportedRedirectToHoldServices>\(_supportedRedirectToHoldServices)</SupportedRedirectToHoldServices>" }
    func requiredLocationAttributes() -> String { return "<RequiredLocationAttributes>\(_requiredLocationAttributes)</RequiredLocationAttributes>" }
    func requiredLocationCapabilities() -> String { return "<RequiredLocationCapabilities>\(_requiredLocationCapabilities)</RequiredLocationCapabilities>" }
    func shipmentDetail() -> String { return "<ShipmentDetail>\(_shipmentDetail)</ShipmentDetail>" }
    func resultsToSkip() -> String { return "<ResultsToSkip>\(_resultsToSkip)</ResultsToSkip>" }
    func resultsRequested() -> String { return "<ResultsRequested>\(_resultsRequested)</ResultsRequested>" }
    func locationContentOptions() -> String { return "<LocationContentOptions>\(_locationContentOptions)</LocationContentOptions>" }
    func locationTypesToInclude() -> String { return "<LocationTypesToInclude>\(_locationTypesToInclude)</LocationTypesToInclude>" }
}

struct LocationCapabilityDetail : CustomStringConvertible
{
    let _carrierCode: CarrierCodeType
    let _serviceType: ServiceType
    let _serviceCategory: ServiceCategoryType
    let _transferOfPossessionType: LocationTransferOfPossessionType
    let _daysOfWeek: DayOfWeekType
    
    var description: String { return "\(carrierCode())\(serviceType())\(serviceCategory())\(transferOfPossessionType())\(daysOfWeek())"}
    
    init(carrierCode: CarrierCodeType, serviceType: ServiceType, serviceCategory: ServiceCategoryType, transferOfPossessionType: LocationTransferOfPossessionType, daysOfWeek: DayOfWeekType)
    {
        _carrierCode = carrierCode
        _serviceType = serviceType
        _serviceCategory = serviceCategory
        _transferOfPossessionType = transferOfPossessionType
        _daysOfWeek = daysOfWeek
    }
    
    func carrierCode() -> String { return "<CarrierCode>\(_carrierCode)</CarrierCode>" }
    func serviceType() -> String { return "<ServiceType>\(_serviceType)</ServiceType>" }
    func serviceCategory() -> String { return "<ServiceCategory>\(_serviceCategory)</ServiceCategory>" }
    func transferOfPossessionType() -> String { return "<TransferOfPossessionType>\(_transferOfPossessionType)</TransferOfPossessionType>" }
    func daysOfWeek() -> String { return "<DaysOfWeek>\(_daysOfWeek)</DaysOfWeek>" }
}

struct LocationSupportedShipmentDetail : CustomStringConvertible
{
    let _packageDetails: LocationSupportedPackageDetail
    
    var description: String { return "\(packageDetails())" }
    
    init(packageDetails: LocationSupportedPackageDetail)
    {
        _packageDetails = packageDetails
    }
    
    func packageDetails() -> String { return "<PackageDetails>\(_packageDetails)</PackageDetails>" }
}

struct LocationSupportedPackageDetail : CustomStringConvertible
{
    let _weight: Weight
    let _dimensions: Dimensions
    
    var description: String { return "\(weight())(dimensions())"}
    
    init(weight: Weight, dimensions: Dimensions)
    {
        _weight = weight
        _dimensions = Dimensions
    }
    
    func weight() -> String { return "<Weight>\(_weight)</Weight>" }
    func dimensions() -> String { return "<Dimensions>\(_dimensions)</Dimensions>" }
}
