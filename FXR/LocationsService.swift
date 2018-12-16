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
    fileprivate let _locationsSearchCriterion: LocationsSearchCriteriaType?
    fileprivate let _shipperAccountNumber: String?
    fileprivate let _uniqueTrackingNumber: UniqueTrackingNumber?
    fileprivate let _address: Address?
    fileprivate let _phoneNumber: String?
    fileprivate let _geographicCoordinates: String?
    fileprivate let _multipleMatchesAction: MultipleMatchesActionType?
    fileprivate let _sortDetail: LocationSortDetail?
    fileprivate let _constraints: SearchLocationConstraints?
    
    var description: String { return "\(SoapMessage("<\(type(of: self))>\(webAuthenticationDetail())\(clientDetail())\(transactionDetail())\(version())\(effectiveDate())\(locationsSearchCriterion())\(shipperAccountNumber())\(uniqueTrackingNumber())\(address())\(phoneNumber())\(geographicCoordinates())\(multipleMatchesAction())\(sortDetail())\(constraints())</\(type(of: self))>"))" }
    
    init(webAuthenticationDetail: WebAuthenticationDetail,
         clientDetail: ClientDetail,
         transactionDetail: TransactionDetail?,
         effectiveDate: Date?,
         locationsSearchCriterion: LocationsSearchCriteriaType?,
         shipperAccountNumber: String?,
         uniqueTrackingNumber: UniqueTrackingNumber?,
         address: Address?,
         phoneNumber: String?,
         geographicalCoordinates: String?,
         multipleMatchesAction: MultipleMatchesActionType?,
         sortDetail: LocationSortDetail?,
         constraints: SearchLocationConstraints?)
    {
        _webAuthenticationDetail = webAuthenticationDetail
        _clientDetail = clientDetail
        _transactionDetail = transactionDetail
        _version = VersionId()
        _effectiveDate = effectiveDate
        _locationsSearchCriterion = locationsSearchCriterion
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
	func effectiveDate() -> String { return "<EffectiveDate>\(_effectiveDate!)</EffectiveDate>" }
	func locationsSearchCriterion() -> String { return "<LocationsSearchCriterion>\(_locationsSearchCriterion!)</LocationsSearchCriterion>" }
	func shipperAccountNumber() -> String { return "<ShipperAccountNumber>\(_shipperAccountNumber!)</ShipperAccountNumber>" }
	func uniqueTrackingNumber() -> String { return "<UniqueTrackingNumber>\(_uniqueTrackingNumber!)</UniqueTrackingNumber>" }
	func address() -> String { return "<Address>\(_address!)</Address>" }
	func phoneNumber() -> String { return "<PhoneNumber>\(_phoneNumber!)</PhoneNumber>" }
	func geographicCoordinates() -> String { return "<GeographicCoordinates>\(_geographicCoordinates!)</GeographicCoordinates>" }
	func multipleMatchesAction() -> String { return "<MultipleMatchesAction>\(_multipleMatchesAction!)</MultipleMatchesAction>" }
	func sortDetail() -> String { return "<SortDetail>\(_sortDetail!)</SortDetail>" }
	func constraints() -> String { return "<Constraints>\(_constraints!)</Constraints>" }
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

struct UniqueTrackingNumber : CustomStringConvertible
{
    let _trackingNumber : String?
    let _trackingNumberUniqueIdentifier : String?
    let _shipDate : Date?
    
    var description: String { return "\(trackingNumber())\(trackingNumberUniqueIdentifier())\(shipDate())" }
   
    func trackingNumber() -> String { return "<TrackingNumber>\(_trackingNumber!)</TrackingNumber>" }
    func trackingNumberUniqueIdentifier() -> String { return "<TrackingNumberUniqueIdentifier>\(_trackingNumberUniqueIdentifier!)</TrackingNumberUniqueIdentifier>" }
    func shipDate() -> String { return (_shipDate == nil ? "" : "<ShipDate>\(formatDate(_shipDate!))</ShipDate>") }
}

struct LocationSortDetail : CustomStringConvertible
{
    let _criterion: LocationSortCriteriaType?
    let _order: LocationSortOrderType?
    
    var description: String { return "\(criterion())\(order())" }
    
    init(criterion: LocationSortCriteriaType, order: LocationSortOrderType)
    {
        _criterion = criterion
        _order = order
    }
    
    func criterion() -> String { return "<Criterion>\(_criterion!)</Criterion>" }
    func order() -> String { return "<Order>\(_order!)</Order>" }
}

struct SearchLocationConstraints : CustomStringConvertible
{
    let _radiusDistance: Distance?
    let _dropOffTimeNeeded: Date?
    let _resultsFilters: LocationSearchFilterType?
    let _supportedRedirectToHoldServices: SupportedRedirectToHoldServiceType?
    let _requiredLocationAttributes: LocationAttributesType?
    let _requiredLocationCapabilities: LocationCapabilityDetail?
    let _shipmentDetail: LocationSupportedShipmentDetail?
    let _resultsToSkip: UInt?
    let _resultsRequested: UInt?
    let _locationContentOptions: LocationContentOptionType?
    let _locationTypesToInclude: FedExLocationType?
    
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
    
    func radiusDistance() -> String { return "<RadiusDistance>\(_radiusDistance!)</RadiusDistance>" }
    func dropOffTimeNeeded() -> String { return "<DropOffTimeNeeded>\(_dropOffTimeNeeded!)</DropOffTimeNeeded>" }
    func resultsFilters() -> String { return "<ResultsFilters>\(_resultsFilters!)</ResultsFilters>" }
    func supportedRedirectToHoldServices() -> String { return "<SupportedRedirectToHoldServices>\(_supportedRedirectToHoldServices!)</SupportedRedirectToHoldServices>" }
    func requiredLocationAttributes() -> String { return "<RequiredLocationAttributes>\(_requiredLocationAttributes!)</RequiredLocationAttributes>" }
    func requiredLocationCapabilities() -> String { return "<RequiredLocationCapabilities>\(_requiredLocationCapabilities!)</RequiredLocationCapabilities>" }
    func shipmentDetail() -> String { return "<ShipmentDetail>\(_shipmentDetail!)</ShipmentDetail>" }
    func resultsToSkip() -> String { return (_resultsToSkip == nil ? "" : "<ResultsToSkip>\(_resultsToSkip!)</ResultsToSkip>") }
	func resultsRequested() -> String { return (_resultsRequested == nil ? "" : "<ResultsRequested>\(_resultsRequested!)</ResultsRequested>") }
    func locationContentOptions() -> String { return "<LocationContentOptions>\(_locationContentOptions!)</LocationContentOptions>" }
    func locationTypesToInclude() -> String { return "<LocationTypesToInclude>\(_locationTypesToInclude!)</LocationTypesToInclude>" }
}

struct LocationCapabilityDetail : CustomStringConvertible
{
    let _carrierCode: CarrierCodeType?
    let _serviceType: ServiceType?
    let _serviceCategory: ServiceCategoryType?
    let _transferOfPossessionType: LocationTransferOfPossessionType?
    let _daysOfWeek: DayOfWeekType?
    
    var description: String { return "\(carrierCode())\(serviceType())\(serviceCategory())\(transferOfPossessionType())\(daysOfWeek())"}
    
    init(carrierCode: CarrierCodeType, serviceType: ServiceType, serviceCategory: ServiceCategoryType, transferOfPossessionType: LocationTransferOfPossessionType, daysOfWeek: DayOfWeekType)
    {
        _carrierCode = carrierCode
        _serviceType = serviceType
        _serviceCategory = serviceCategory
        _transferOfPossessionType = transferOfPossessionType
        _daysOfWeek = daysOfWeek
    }
    
    func carrierCode() -> String { return "<CarrierCode>\(_carrierCode!)</CarrierCode>" }
    func serviceType() -> String { return "<ServiceType>\(_serviceType!)</ServiceType>" }
    func serviceCategory() -> String { return "<ServiceCategory>\(_serviceCategory!)</ServiceCategory>" }
    func transferOfPossessionType() -> String { return "<TransferOfPossessionType>\(_transferOfPossessionType!)</TransferOfPossessionType>" }
    func daysOfWeek() -> String { return "<DaysOfWeek>\(_daysOfWeek!)</DaysOfWeek>" }
}

struct LocationSupportedShipmentDetail : CustomStringConvertible
{
    let _packageDetails: LocationSupportedPackageDetail?
    
    var description: String { return "\(packageDetails())" }
    
    init(packageDetails: LocationSupportedPackageDetail)
    {
        _packageDetails = packageDetails
    }
    
    func packageDetails() -> String { return "<PackageDetails>\(_packageDetails!)</PackageDetails>" }
}

struct LocationSupportedPackageDetail : CustomStringConvertible
{
    let _weight: Weight?
    let _dimensions: Dimensions?
    
    var description: String { return "\(weight())(dimensions())"}
    
    init(weight: Weight, dimensions: Dimensions)
    {
        _weight = weight
        _dimensions = dimensions
    }
    
    func weight() -> String { return "<Weight>\(_weight!)</Weight>" }
    func dimensions() -> String { return "<Dimensions>\(_dimensions!)</Dimensions>" }
}
