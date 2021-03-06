//
//  WsdlEnums.swift
//  FXR
//
//  Created by Tobey Unruh on 3/24/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Foundation

extension RawRepresentable {
	init?(rawValue optionalRawValue: RawValue?) {
		guard let rawValue = optionalRawValue, let value = Self(rawValue: rawValue) else { return nil }
		
		self = value
	}
}

enum NotificationSeverityType: String
{
	case ERROR
	case FAILURE
	case NOTE
	case SUCCESS
	case WARNING
}

enum CarrierCodeType: String
{
	case FDXC
	case FDXE
	case FDXG
	case FXCC
	case FXFR
	case FXSP
}

enum ExpressRegionCode: String
{
	case APAC
	case CA
	case EMEA
	case LAC
	case US
}

enum FreightRateQuoteType: String
{
	case AUTOMATED
	case MANUAL
}

enum FreightBaseChargeCalculationType: String
{
	case LINE_ITEMS
	case UNIT_PRICING
}

enum FreightChargeBasisType: String
{
	case CWT
	case FLAT
	case MINIMUM
}

enum SurchargeLevelType: String
{
	case PACKAGE
	case SHIPMENT
}

enum TaxType: String
{
	case EXPORT
	case GST
	case HST
	case INTRACOUNTRY
	case OTHER
	case PST
	case VAT
}

enum AncillaryFeeAndTaxType: String
{
	case CLEARANCE_ENTRY_FEE
	case GOODS_AND_SERVICES_TAX
	case HARMONIZED_SALES_TAX
	case OTHER
}

enum RequiredShippingDocumentType: String
{
	case CANADIAN_B13A
	case CERTIFICATE_OF_ORIGIN
	case COMMERCIAL_INVOICE
	case INTERNATIONAL_AIRWAY_BILL
	case MAIL_SERVICE_AIRWAY_BILL
	case SHIPPERS_EXPORT_DECLARATION
}

enum DelayLevelType: String
{
	case CITY
	case COUNTRY
	case LOCATION
	case POSTAL_CODE
	case SERVICE_AREA
	case SERVICE_AREA_SPECIAL_SERVICE
	case SPECIAL_SERVICE
}

enum DelayPointType: String
{
	case BROKER
	case DESTINATION
	case ORIGIN
	case ORIGIN_DESTINATION_PAIR
	case PROOF_OF_DELIVERY_POINT
}

enum DistanceUnits: String
{
	case KM
	case MI
}

enum CommitmentDelayType: String
{
	case HOLIDAY
	case NON_WORKDAY
	case NO_CITY_DELIVERY
	case NO_HOLD_AT_LOCATION
	case NO_LOCATION_DELIVERY
	case NO_SERVICE_AREA_DELIVERY
	case NO_SERVICE_AREA_SPECIAL_SERVICE_DELIVERY
	case NO_SPECIAL_SERVICE_DELIVERY
	case NO_ZIP_DELIVERY
	case WEEKEND
	case WEEKEND_SPECIAL
}

enum FreightServiceSchedulingType: String
{
	case LIMITED
	case STANDARD
	case WILL_CALL
}

enum TrackingIdType: String
{
	case EXPRESS
	case FEDEX
	case GROUND
	case USPS
}

enum RateDiscountType: String
{
	case BONUS
	case COUPON
	case EARNED
	case OTHER
	case VOLUME
}

enum RebateType: String
{
	case BONUS
	case EARNED
	case OTHER
}

enum ServiceOptionType: String
{
	case FEDEX_ONE_RATE
	case FREIGHT_GUARANTEE
	case SATURDAY_DELIVERY
	case SMART_POST_ALLOWED_INDICIA
	case SMART_POST_HUB_ID
}

enum OversizeClassType: String
{
	case OVERSIZE_1
	case OVERSIZE_2
	case OVERSIZE_3
}

enum ConsolidationType: String
{
	case INTERNATIONAL_DISTRIBUTION_FREIGHT
	case INTERNATIONAL_ECONOMY_DISTRIBUTION
	case INTERNATIONAL_GROUND_DIRECT_DISTRIBUTION
	case INTERNATIONAL_GROUND_DISTRIBUTION
	case INTERNATIONAL_PRIORITY_DISTRIBUTION
	case TRANSBORDER_DISTRIBUTION
}

enum DropoffType: String
{
	case BUSINESS_SERVICE_CENTER
	case DROP_BOX
	case REGULAR_PICKUP
	case REQUEST_COURIER
	case STATION
}

enum TinType: String
{
	case BUSINESS_NATIONAL
	case BUSINESS_STATE
	case PERSONAL_NATIONAL
	case PERSONAL_STATE
}

enum PaymentType: String
{
	case SENDER
}

enum FedExLocationType: String
{
	case FEDEX_EXPRESS_STATION
	case FEDEX_FACILITY
	case FEDEX_FREIGHT_SERVICE_CENTER
	case FEDEX_GROUND_TERMINAL
	case FEDEX_HOME_DELIVERY_STATION
	case FEDEX_OFFICE
	case FEDEX_SHIPSITE
	case FEDEX_SMART_POST_HUB
}

enum ShipmentNotificationRoleType: String
{
	case BROKER
	case OTHER
	case RECIPIENT
	case SHIPPER
	case THIRD_PARTY
}

enum NotificationEventType: String
{
	case ON_DELIVERY
	case ON_ESTIMATED_DELIVERY
	case ON_EXCEPTION
	case ON_SHIPMENT
	case ON_TENDER
}

enum NotificationType: String
{
	case EMAIL
}

enum NotificationFormatType: String
{
	case HTML
	case TEXT
}

enum ShipmentNotificationAggregationType: String
{
	case PER_PACKAGE
	case PER_SHIPMENT
}

enum ReturnEMailAllowedSpecialServiceType: String
{
	case SATURDAY_DELIVERY
	case SATURDAY_PICKUP
}

enum ReturnType: String
{
	case FEDEX_TAG
	case PENDING
	case PRINT_RETURN_LABEL
}

enum PendingShipmentType: String
{
	case EMAIL
}

enum PendingShipmentProcessingOptionType: String
{
	case ALLOW_MODIFICATIONS
}

enum RecommendedDocumentType: String
{
	case ANTIQUE_STATEMENT_EUROPEAN_UNION
	case ANTIQUE_STATEMENT_UNITED_STATES
	case ASSEMBLER_DECLARATION
	case BEARING_WORKSHEET
	case CERTIFICATE_OF_SHIPMENTS_TO_SYRIA
	case COMMERCIAL_INVOICE_FOR_THE_CARIBBEAN_COMMON_MARKET
	case CONIFEROUS_SOLID_WOOD_PACKAGING_MATERIAL_TO_THE_PEOPLES_REPUBLIC_OF_CHINA
	case DECLARATION_FOR_FREE_ENTRY_OF_RETURNED_AMERICAN_PRODUCTS
	case DECLARATION_OF_BIOLOGICAL_STANDARDS
	case DECLARATION_OF_IMPORTED_ELECTRONIC_PRODUCTS_SUBJECT_TO_RADIATION_CONTROL_STANDARD
	case ELECTRONIC_INTEGRATED_CIRCUIT_WORKSHEET
	case FILM_AND_VIDEO_CERTIFICATE
	case INTERIM_FOOTWEAR_INVOICE
	case NAFTA_CERTIFICATE_OF_ORIGIN_CANADA_ENGLISH
	case NAFTA_CERTIFICATE_OF_ORIGIN_CANADA_FRENCH
	case NAFTA_CERTIFICATE_OF_ORIGIN_SPANISH
	case NAFTA_CERTIFICATE_OF_ORIGIN_UNITED_STATES
	case PACKING_LIST
	case PRINTED_CIRCUIT_BOARD_WORKSHEET
	case REPAIRED_WATCH_BREAKOUT_WORKSHEET
	case STATEMENT_REGARDING_THE_IMPORT_OF_RADIO_FREQUENCY_DEVICES
	case TOXIC_SUBSTANCES_CONTROL_ACT
	case UNITED_STATES_CARIBBEAN_BASIN_TRADE_PARTNERSHIP_ACT_CERTIFICATE_OF_ORIGIN_NON_TEXTILES
	case UNITED_STATES_CARIBBEAN_BASIN_TRADE_PARTNERSHIP_ACT_CERTIFICATE_OF_ORIGIN_TEXTILES
	case UNITED_STATES_NEW_WATCH_WORKSHEET
	case UNITED_STATES_WATCH_REPAIR_DECLARATION
}

enum InternationalControlledExportType: String
{
	case DEA_036
	case DEA_236
	case DEA_486
	case DSP_05
	case DSP_61
	case DSP_73
	case DSP_85
	case DSP_94
	case DSP_LICENSE_AGREEMENT
	case FROM_FOREIGN_TRADE_ZONE
	case WAREHOUSE_WITHDRAWAL
}

enum ShipmentDryIceProcessingOptionType: String
{
	case SHIPMENT_LEVEL_DRY_ICE_ONLY
}

enum HomeDeliveryPremiumType: String
{
	case APPOINTMENT
	case DATE_CERTAIN
	case EVENING
}

enum FlatbedTrailerOption: String
{
	case OVER_DIMENSION
	case TARP
}

enum RequestedShippingDocumentType: String
{
	case CERTIFICATE_OF_ORIGIN
	case COMMERCIAL_INVOICE
	case CUSTOMER_SPECIFIED_LABELS
	case DANGEROUS_GOODS_SHIPPERS_DECLARATION
	case EXPORT_DECLARATION
	case GENERAL_AGENCY_AGREEMENT
	case LABEL
	case NAFTA_CERTIFICATE_OF_ORIGIN
	case PRO_FORMA_INVOICE
	case RETURN_INSTRUCTIONS
}

enum UploadDocumentProducerType: String
{
	case CUSTOMER
	case FEDEX_CAFE
	case FEDEX_CLS
	case FEDEX_FIDT
	case FEDEX_FXRS
	case FEDEX_GSMW
	case FEDEX_GTM
	case OTHER
}

enum UploadDocumentType: String
{
	case CERTIFICATE_OF_ORIGIN
	case COMMERCIAL_INVOICE
	case ETD_LABEL
	case NAFTA_CERTIFICATE_OF_ORIGIN
	case OTHER
	case PRO_FORMA_INVOICE
}

enum UploadDocumentIdProducer: String
{
	case CUSTOMER
	case FEDEX_CAFE
	case FEDEX_CSHP
	case FEDEX_FXRS
	case FEDEX_GSMW
	case FEDEX_GTM
	case FEDEX_INET
}

enum CustomDeliveryWindowType: String
{
	case AFTER
	case BEFORE
	case BETWEEN
	case ON
}

enum ShipmentSpecialServiceType: String
{
	case BROKER_SELECT_OPTION = "Broker Select Option"
	case CALL_BEFORE_DELIVERY = "Call Before Delivery"
	case COD = "COD"
	case CUSTOM_DELIVERY_WINDOW = "Custom Delivery Window"
	case CUT_FLOWERS = "Cut Flowers"
	case DANGEROUS_GOODS = "Dangerous Goods"
	case DO_NOT_BREAK_DOWN_PALLETS = "Do Not Break Down Pallets"
	case DO_NOT_STACK_PALLETS = "Do Not Stack Pallets"
	case DRY_ICE = "Dry Ice"
	case EAST_COAST_SPECIAL = "East Coast Special"
	case ELECTRONIC_TRADE_DOCUMENTS = "Electronic Trade Documents"
	case EVENT_NOTIFICATION = "Event Notification"
	case EXTREME_LENGTH = "Extreme Length"
	case FEDEX_ONE_RATE = "FedEx One Rate"
	case FOOD = "Food"
	case FREIGHT_GUARANTEE = "Freight Guarantee"
	case FREIGHT_TO_COLLECT = "Freight to Collect"
	case FUTURE_DAY_SHIPMENT = "Future Day Shipment"
	case HOLD_AT_LOCATION = "Hold at Location"
	case HOME_DELIVERY_PREMIUM = "Home Delivery Premium"
	case INSIDE_DELIVERY = "Inside Delivery"
	case INSIDE_PICKUP = "Inside Pickup"
	case INTERNATIONAL_CONTROLLED_EXPORT_SERVICE = "International Controlled Export Service"
	case INTERNATIONAL_TRAFFIC_IN_ARMS_REGULATIONS = "International Traffic in Arms Regulations"
	case LIFTGATE_DELIVERY = "Liftgate Delivery"
	case LIFTGATE_PICKUP = "Liftgate Pickup"
	case LIMITED_ACCESS_DELIVERY = "Limited Access Delivery"
	case LIMITED_ACCESS_PICKUP = "Limited Access Pickup"
	case PENDING_SHIPMENT = "Pending Shipment"
	case PHARMACY_DELIVERY = "Pharmacy Delivery"
	case POISON = "Poison"
	case PROTECTION_FROM_FREEZING = "Protection from Freezing"
	case RETURNS_CLEARANCE = "Returns Clearance"
	case RETURN_SHIPMENT = "Return Shipment"
	case SATURDAY_DELIVERY = "Saturday Delivery"
	case SATURDAY_PICKUP = "Saturday Pickup"
	case THIRD_PARTY_CONSIGNEE = "Third Party Consignee"
	case TOP_LOAD = "Top Load"
	
	static let values = [BROKER_SELECT_OPTION.rawValue,
	                     CALL_BEFORE_DELIVERY.rawValue,
	                     COD.rawValue,
	                     CUSTOM_DELIVERY_WINDOW.rawValue,
	                     CUT_FLOWERS.rawValue,
	                     DANGEROUS_GOODS.rawValue,
	                     DO_NOT_BREAK_DOWN_PALLETS.rawValue,
	                     DO_NOT_STACK_PALLETS.rawValue,
	                     DRY_ICE.rawValue,
	                     EAST_COAST_SPECIAL.rawValue,
	                     ELECTRONIC_TRADE_DOCUMENTS.rawValue,
	                     EVENT_NOTIFICATION.rawValue,
	                     EXTREME_LENGTH.rawValue,
	                     FEDEX_ONE_RATE.rawValue,
	                     FOOD.rawValue,
	                     FREIGHT_GUARANTEE.rawValue,
	                     FREIGHT_TO_COLLECT.rawValue,
	                     FUTURE_DAY_SHIPMENT.rawValue,
	                     HOLD_AT_LOCATION.rawValue,
	                     HOME_DELIVERY_PREMIUM.rawValue,
	                     INSIDE_DELIVERY.rawValue,
	                     INSIDE_PICKUP.rawValue,
	                     INTERNATIONAL_CONTROLLED_EXPORT_SERVICE.rawValue,
	                     INTERNATIONAL_TRAFFIC_IN_ARMS_REGULATIONS.rawValue,
	                     LIFTGATE_DELIVERY.rawValue,
	                     LIFTGATE_PICKUP.rawValue,
	                     LIMITED_ACCESS_DELIVERY.rawValue,
	                     LIMITED_ACCESS_PICKUP.rawValue,
	                     PENDING_SHIPMENT.rawValue,
	                     PHARMACY_DELIVERY.rawValue,
	                     POISON.rawValue,
	                     PROTECTION_FROM_FREEZING.rawValue,
	                     RETURNS_CLEARANCE.rawValue,
	                     RETURN_SHIPMENT.rawValue,
	                     SATURDAY_DELIVERY.rawValue,
	                     SATURDAY_PICKUP.rawValue,
	                     THIRD_PARTY_CONSIGNEE.rawValue,
	                     TOP_LOAD.rawValue]
}

enum FreightShipmentRoleType: String
{
	case CONSIGNEE
	case SHIPPER
}

enum FreightCollectTermsType: String
{
	case NON_RECOURSE_SHIPPER_SIGNED
	case STANDARD
}

enum LiabilityCoverageType: String
{
	case NEW
	case USED_OR_RECONDITIONED
}

enum CommodityPurposeType: String
{
	case BUSINESS
	case CONSUMER
}

enum CustomerReferenceType: String
{
	case BILL_OF_LADING
	case CUSTOMER_REFERENCE
	case DEPARTMENT_NUMBER
	case ELECTRONIC_PRODUCT_CODE
	case INTRACOUNTRY_REGULATORY_REFERENCE
	case INVOICE_NUMBER
	case PACKING_SLIP_NUMBER
	case P_O_NUMBER
	case RMA_ASSOCIATION
	case SHIPMENT_INTEGRITY
	case STORE_NUMBER
}

enum EdtTaxType: String
{
	case ADDITIONAL_TAXES
	case CONSULAR_INVOICE_FEE
	case CUSTOMS_SURCHARGES
	case DUTY
	case EXCISE_TAX
	case FOREIGN_EXCHANGE_TAX
	case GENERAL_SALES_TAX
	case IMPORT_LICENSE_FEE
	case INTERNAL_ADDITIONAL_TAXES
	case INTERNAL_SENSITIVE_PRODUCTS_TAX
	case OTHER
	case SENSITIVE_PRODUCTS_TAX
	case STAMP_TAX
	case STATISTICAL_TAX
	case TRANSPORT_FACILITIES_TAX
}

enum FreightClassType: String
{
	case CLASS_050 = "Class 050"
	case CLASS_055 = "Class 055"
	case CLASS_060 = "Class 060"
	case CLASS_065 = "Class 065"
	case CLASS_070 = "Class 070"
	case CLASS_077_5 = "Class 077.5"
	case CLASS_085 = "Class 085"
	case CLASS_092_5 = "Class 092.5"
	case CLASS_100 = "Class 100"
	case CLASS_110 = "Class 110"
	case CLASS_125 = "Class 125"
	case CLASS_150 = "Class 150"
	case CLASS_175 = "Class 175"
	case CLASS_200 = "Class 200"
	case CLASS_250 = "Class 250"
	case CLASS_300 = "Class 300"
	case CLASS_400 = "Class 400"
	case CLASS_500 = "Class 500"
	
	static let values = [CLASS_050.rawValue,
	                     CLASS_055.rawValue,
	                     CLASS_060.rawValue,
	                     CLASS_065.rawValue,
	                     CLASS_070.rawValue,
	                     CLASS_077_5.rawValue,
	                     CLASS_085.rawValue,
	                     CLASS_092_5.rawValue,
	                     CLASS_100.rawValue,
	                     CLASS_110.rawValue,
	                     CLASS_125.rawValue,
	                     CLASS_150.rawValue,
	                     CLASS_175.rawValue,
	                     CLASS_200.rawValue,
	                     CLASS_250.rawValue,
	                     CLASS_300.rawValue,
	                     CLASS_400.rawValue,
	                     CLASS_500.rawValue]
}

enum VolumeUnits: String
{
	case CUBIC_FT = "Cubic FT"
	case CUBIC_M = "Cubic M"
	
	static let values = [CUBIC_FT.rawValue, CUBIC_M.rawValue]
}

enum RateElementBasisType: String
{
	case BASE_CHARGE
	case NET_CHARGE
	case NET_CHARGE_EXCLUDING_TAXES
	case NET_FREIGHT
}

enum BrokerType: String
{
	case EXPORT
	case IMPORT
}

enum ClearanceBrokerageType: String
{
	case BROKER_INCLUSIVE
	case BROKER_INCLUSIVE_NON_RESIDENT_IMPORTER
	case BROKER_SELECT
	case BROKER_SELECT_NON_RESIDENT_IMPORTER
	case BROKER_UNASSIGNED
}

enum CustomsOptionType: String
{
	case COURTESY_RETURN_LABEL
	case EXHIBITION_TRADE_SHOW
	case FAULTY_ITEM
	case FOLLOWING_REPAIR
	case FOR_REPAIR
	case ITEM_FOR_LOAN
	case OTHER
	case REJECTED
	case REPLACEMENT
	case TRIAL
}

enum RecipientCustomsIdType: String
{
	case COMPANY
	case INDIVIDUAL
	case PASSPORT
}

enum FreightOnValueType: String
{
	case CARRIER_RISK
	case OWN_RISK
}

enum TaxesOrMiscellaneousChargeType: String
{
	case COMMISSIONS
	case DISCOUNTS
	case HANDLING_FEES
	case OTHER
	case ROYALTIES_AND_LICENSE_FEES
	case TAXES
}

enum PurposeOfShipmentType: String
{
	case GIFT
	case NOT_SOLD
	case PERSONAL_EFFECTS
	case REPAIR_AND_RETURN
	case SAMPLE
	case SOLD
}



enum NaftaPreferenceCriterionCode: String
{
	case A
	case B
	case C
	case D
	case E
	case F
}

enum NaftaProducerDeterminationCode: String
{
	case NO_1
	case NO_2
	case NO_3
	case YES
}

enum NaftaNetCostMethodCode: String
{
	case NC
	case NO
}

enum B13AFilingOptionType: String
{
	case FEDEX_TO_STAMP
	case FILED_ELECTRONICALLY
	case MANUALLY_ATTACHED
	case NOT_REQUIRED
	case SUMMARY_REPORTING
}

enum DestinationControlStatementType: String
{
	case DEPARTMENT_OF_COMMERCE
	case DEPARTMENT_OF_STATE
}

enum RegulatoryControlType: String
{
	case EU_CIRCULATION
	case FOOD_OR_PERISHABLE
	case NAFTA
	case NOT_APPLICABLE_FOR_LOW_CUSTOMS_VALUE_EXCEPTION
}

enum PickupRequestType: String
{
	case FUTURE_DAY
	case SAME_DAY
}

enum PickupRequestSourceType: String
{
	case AUTOMATION
	case CUSTOMER_SERVICE
}

enum SmartPostShipmentProcessingOptionType: String
{
	case GROUND_TRACKING_NUMBER_REQUESTED
}

enum SmartPostAncillaryEndorsementType: String
{
	case ADDRESS_CORRECTION
	case CARRIER_LEAVE_IF_NO_RESPONSE
	case CHANGE_SERVICE
	case FORWARDING_SERVICE
	case RETURN_SERVICE
}



enum LabelFormatType: String
{
	case COMMON2D
	case LABEL_DATA_ONLY
	case MAILROOM
	case NO_LABEL
	case OPERATIONAL_LABEL
	case PRE_COMMON2D
}

enum ShippingDocumentImageType: String
{
	case EPL2
	case PDF
	case PNG
	case ZPLII
}

enum LabelStockType: String
{
	case PAPER_4X6 = "PAPER_4X6"
	case PAPER_4X8 = "PAPER_4X8"
	case PAPER_4X9 = "PAPER_4X9"
	case PAPER_7X475 = "PAPER_7X4.75"
	case PAPER_85X11_BOTTOM_HALF_LABEL = "PAPER_8.5X11_BOTTOM_HALF_LABEL"
	case PAPER_85X11_TOP_HALF_LABEL = "PAPER_8.5X11_TOP_HALF_LABEL"
	case STOCK_4X6 = "STOCK_4X6"
	case STOCK_4X675_LEADING_DOC_TAB = "STOCK_4X6.75_LEADING_DOC_TAB"
	case STOCK_4X675_TRAILING_DOC_TAB = "STOCK_4X6.75_TRAILING_DOC_TAB"
	case STOCK_4X8 = "STOCK_4X8"
	case STOCK_4X9_LEADING_DOC_TAB = "STOCK_4X9_LEADING_DOC_TAB"
	case STOCK_4X9_TRAILING_DOC_TAB = "STOCK_4X9_TRAILING_DOC_TAB"
}

enum ShippingDocumentDispositionType: String
{
	case CONFIRMED
	case DEFERRED_QUEUED
	case DEFERRED_RETURNED
	case DEFERRED_STORED
	case EMAILED
	case QUEUED
	case RETURNED
	case STORED
}

enum ShippingDocumentGroupingType: String
{
	case CONSOLIDATED_BY_DOCUMENT_TYPE
	case INDIVIDUAL
}

enum EMailNotificationRecipientType: String
{
	case BROKER
	case OTHER
	case RECIPIENT
	case SHIPPER
}

enum ShippingDocumentEMailGroupingType: String
{
	case BY_RECIPIENT
	case NONE
}

enum ShippingDocumentStockType: String
{
	case OP_900_LG_B = "OP_900_LG_B"
	case OP_900_LL_B = "OP_900_LL_B"
	case PAPER_4X6 = "PAPER_4X6"
	case PAPER_LETTER = "PAPER_LETTER"
	case STOCK_4X6 = "STOCK_4X6"
	case STOCK_4X675_LEADING_DOC_TAB = "STOCK_4X6.75_LEADING_DOC_TAB"
	case STOCK_4X675_TRAILING_DOC_TAB = "STOCK_4X6.75_TRAILING_DOC_TAB"
	case STOCK_4X8 = "STOCK_4X8"
	case STOCK_4X9_LEADING_DOC_TAB = "STOCK_4X9_LEADING_DOC_TAB"
	case STOCK_4X9_TRAILING_DOC_TAB = "STOCK_4X9_TRAILING_DOC_TAB"
}

enum DocumentFormatOptionType: String
{
	case SUPPRESS_ADDITIONAL_LANGUAGES
}

enum CustomerImageUsageType: String
{
	case LETTER_HEAD
	case SIGNATURE
}

enum ImageId: String
{
	case IMAGE_1
	case IMAGE_2
	case IMAGE_3
	case IMAGE_4
	case IMAGE_5
}

enum CustomLabelCoordinateUnits: String
{
	case MILS
	case PIXELS
}

enum RotationType: String
{
	case LEFT
	case NONE
	case RIGHT
	case UPSIDE_DOWN
}

enum BarcodeSymbologyType: String
{
	case CODABAR
	case CODE128
	case CODE128B
	case CODE128C
	case CODE128_WIDEBAR
	case CODE39
	case CODE93
	case I2OF5
	case MANUAL
	case PDF417
	case POSTNET
	case QR_CODE
	case UCC128
}

enum NaftaImporterSpecificationType: String
{
	case IMPORTER_OF_RECORD
	case RECIPIENT
	case UNKNOWN
	case VARIOUS
}

enum NaftaProducerSpecificationType: String
{
	case AVAILABLE_UPON_REQUEST
	case MULTIPLE_SPECIFIED
	case SAME
	case SINGLE_SPECIFIED
	case UNKNOWN
}

enum PageQuadrantType: String
{
	case BOTTOM_LEFT
	case BOTTOM_RIGHT
	case TOP_LEFT
	case TOP_RIGHT
}

enum DocTabContentType: String
{
	case BARCODED
	case CUSTOM
	case MINIMUM
	case STANDARD
	case ZONE001
}

enum DocTabZoneJustificationType: String
{
	case LEFT
	case RIGHT
}

enum RelativeVerticalPositionType: String
{
	case ABOVE
	case BELOW
}



enum LabelPrintingOrientationType: String
{
	case BOTTOM_EDGE_OF_TEXT_FIRST
	case TOP_EDGE_OF_TEXT_FIRST
}

enum LabelRotationType: String
{
	case LEFT
	case NONE
	case RIGHT
	case UPSIDE_DOWN
}

enum LabelOrderType: String
{
	case SHIPPING_LABEL_FIRST
	case SHIPPING_LABEL_LAST
}

enum LabelMaskableDataType: String
{
	case CUSTOMS_VALUE
	case DIMENSIONS
	case DUTIES_AND_TAXES_PAYOR_ACCOUNT_NUMBER
	case FREIGHT_PAYOR_ACCOUNT_NUMBER
	case PACKAGE_SEQUENCE_AND_COUNT
	case SECONDARY_BARCODE
	case SHIPPER_ACCOUNT_NUMBER
	case SUPPLEMENTAL_LABEL_DOC_TAB
	case TERMS_AND_CONDITIONS
	case TOTAL_WEIGHT
	case TRANSPORTATION_CHARGES_PAYOR_ACCOUNT_NUMBER
}

enum SecondaryBarcodeType: String
{
	case COMMON_2D
	case NONE
	case SSCC_18
	case USPS
}

enum RegulatoryLabelType: String
{
	case ALCOHOL_SHIPMENT_LABEL
}

enum CustomerSpecifiedLabelGenerationOptionType: String
{
	case CONTENT_ON_SHIPPING_LABEL_ONLY
	case CONTENT_ON_SHIPPING_LABEL_PREFERRED
	case CONTENT_ON_SUPPLEMENTAL_LABEL_ONLY
}

enum AdditionalLabelsType: String
{
	case BROKER
	case CONSIGNEE
	case CUSTOMS
	case DESTINATION
	case MANIFEST
	case ORIGIN
	case RECIPIENT
	case SHIPPER
}

enum RateRequestType: String
{
	case LIST
	case NONE
	case PREFERRED
}

enum EdtRequestType: String
{
	case ALL
	case NONE
}

enum ShipmentOnlyFieldsType: String
{
	case DIMENSIONS
	case INSURED_VALUE
	case WEIGHT
}

enum HazardousCommodityRegulationType: String
{
	case ADR
	case DOT
	case IATA
	case ORMD
}

enum DangerousGoodsAccessibilityType: String
{
	case ACCESSIBLE = "Accessible"
	case INACCESSIBLE = "Inaccessible"
	
	static let values = [ACCESSIBLE.rawValue, INACCESSIBLE.rawValue]
}

enum HazardousCommodityOptionType: String
{
	case BATTERY
	case HAZARDOUS_MATERIALS
	case LIMITED_QUANTITIES_COMMODITIES
	case ORM_D
	case REPORTABLE_QUANTITIES
	case SMALL_QUANTITY_EXCEPTION
}

enum DangerousGoodsPackingOptionType: String
{
	case OVERPACK
}

enum HazardousContainerPackingType: String
{
	case ALL_PACKED_IN_ONE
}

enum RadioactiveContainerClassType: String
{
	case EXCEPTED_PACKAGE
	case INDUSTRIAL_IP1
	case INDUSTRIAL_IP2
	case INDUSTRIAL_IP3
	case TYPE_A
	case TYPE_B_M
	case TYPE_B_U
	case TYPE_C
}

enum HazardousCommodityPackingGroupType: String
{
	case DEFAULT
	case I
	case II
	case III
}

enum HazardousCommodityDescriptionProcessingOptionType: String
{
	case INCLUDE_SPECIAL_PROVISIONS
}

enum HazardousCommodityQuantityType: String
{
	case GROSS
	case NET
}

enum HazardousCommodityLabelTextOptionType: String
{
	case APPEND
	case OVERRIDE
	case STANDARD
}

enum RadioactivityUnitOfMeasure: String
{
	case BQ
	case GBQ
	case KBQ
	case MBQ
	case PBQ
	case TBQ
}

enum PhysicalFormType: String
{
	case GAS
	case LIQUID
	case SOLID
	case SPECIAL
}

enum NetExplosiveClassificationType: String
{
	case NET_EXPLOSIVE_CONTENT
	case NET_EXPLOSIVE_MASS
	case NET_EXPLOSIVE_QUANTITY
	case NET_EXPLOSIVE_WEIGHT
}



enum LinearUnits: String
{
	case CM
	case IN
	
	static let values = [CM.rawValue, IN.rawValue]
}

enum PhysicalPackagingType: String
{
	case BAG
	case BARREL
	case BASKET
	case BOX
	case BUCKET
	case BUNDLE
	case CARTON
	case CASE
	case CONTAINER
	case CRATE
	case CYLINDER
	case DRUM
	case ENVELOPE
	case HAMPER
	case OTHER
	case PAIL
	case PALLET
	case PIECE
	case REEL
	case ROLL
	case SKID
	case TANK
	case TUBE
	
	static let values = [BAG.rawValue,
	                     BARREL.rawValue,
	                     BASKET.rawValue,
	                     BOX.rawValue,
	                     BUCKET.rawValue,
	                     BUNDLE.rawValue,
	                     CARTON.rawValue,
	                     CASE.rawValue,
	                     CONTAINER.rawValue,
	                     CRATE.rawValue,
	                     CYLINDER.rawValue,
	                     DRUM.rawValue,
	                     ENVELOPE.rawValue,
	                     HAMPER.rawValue,
	                     OTHER.rawValue,
	                     PAIL.rawValue,
	                     PALLET.rawValue,
	                     PIECE.rawValue,
	                     REEL.rawValue,
	                     ROLL.rawValue,
	                     SKID.rawValue,
	                     TANK.rawValue,
	                     TUBE.rawValue]
}

enum PackageSpecialServiceType: String
{
	case ALCOHOL = "Alcohol"
	case APPOINTMENT_DELIVERY = "Appointment Delivery"
	case COD = "COD"
	case DANGEROUS_GOODS = "Dangerous Goods"
	case DRY_ICE = "Dry Ice"
	case NON_STANDARD_CONTAINER = "Non-Standard Container"
	case PRIORITY_ALERT = "Priority Alert"
	case SIGNATURE_OPTION = "Signature Option"
	
	static let values = [ALCOHOL.rawValue,
	                     APPOINTMENT_DELIVERY.rawValue,
	                     COD.rawValue,
	                     DANGEROUS_GOODS.rawValue,
	                     DRY_ICE.rawValue,
	                     NON_STANDARD_CONTAINER.rawValue,
	                     PRIORITY_ALERT.rawValue,
	                     SIGNATURE_OPTION.rawValue]
}

enum RateTypeBasisType: String
{
	case ACCOUNT
	case LIST
}

enum CodAddTransportationChargeBasisType: String
{
	case COD_SURCHARGE
	case NET_CHARGE
	case NET_FREIGHT
	case TOTAL_CUSTOMER_CHARGE
}

enum ChargeBasisLevelType: String
{
	case CURRENT_PACKAGE
	case SUM_OF_PACKAGES
}

enum CodCollectionType: String
{
	case ANY = "Any"
	case CASH = "Cash"
	case GUARANTEED_FUNDS = "Guaranteed Funds"
	
	static let values = [ANY.rawValue, CASH.rawValue, GUARANTEED_FUNDS.rawValue]
}

enum CodReturnReferenceIndicatorType: String
{
	case INVOICE
	case PO
	case REFERENCE
	case TRACKING
}

enum PriorityAlertEnhancementType: String
{
	case PRIORITY_ALERT_PLUS = "Priority Alert Plus"
	
	static let values = [PRIORITY_ALERT_PLUS.rawValue]
}

enum AlcoholRecipientType: String
{
	case CONSUMER = "Consumer"
	case LICENSEE = "Licensee"
	
	static let values = [CONSUMER.rawValue, LICENSEE.rawValue]
}

enum FreightGuaranteeType: String
{
	case GUARANTEED_DATE
	case GUARANTEED_MORNING
}

enum SmartPostIndiciaType: String
{
	case MEDIA_MAIL
	case PARCEL_RETURN
	case PARCEL_SELECT
	case PRESORTED_BOUND_PRINTED_MATTER
	case PRESORTED_STANDARD
}

enum DayOfWeekType: String
{
	case FRI
	case MON
	case SAT
	case SUN
	case THU
	case TUE
	case WED
}

enum TransitTimeType: String
{
	case EIGHTEEN_DAYS
	case EIGHT_DAYS
	case ELEVEN_DAYS
	case FIFTEEN_DAYS
	case FIVE_DAYS
	case FOURTEEN_DAYS
	case FOUR_DAYS
	case NINETEEN_DAYS
	case NINE_DAYS
	case ONE_DAY
	case SEVENTEEN_DAYS
	case SEVEN_DAYS
	case SIXTEEN_DAYS
	case SIX_DAYS
	case TEN_DAYS
	case THIRTEEN_DAYS
	case THREE_DAYS
	case TWELVE_DAYS
	case TWENTY_DAYS
	case TWO_DAYS
	case UNKNOWN
}

enum PricingCodeType: String
{
	case ACTUAL
	case ALTERNATE
	case BASE
	case HUNDREDWEIGHT
	case HUNDREDWEIGHT_ALTERNATE
	case INTERNATIONAL_DISTRIBUTION
	case INTERNATIONAL_ECONOMY_SERVICE
	case LTL_FREIGHT
	case PACKAGE
	case SHIPMENT
	case SHIPMENT_FIVE_POUND_OPTIONAL
	case SHIPMENT_OPTIONAL
	case SPECIAL
}

enum RatedWeightMethod: String
{
	case ACTUAL
	case AVERAGE_PACKAGE_WEIGHT_MINIMUM
	case BALLOON
	case DEFAULT_WEIGHT_APPLIED
	case DIM
	case FREIGHT_MINIMUM
	case MIXED
	case OVERSIZE
	case OVERSIZE_1
	case OVERSIZE_2
	case OVERSIZE_3
	case PACKAGING_MINIMUM
	case WEIGHT_BREAK
}

enum MinimumChargeType: String
{
	case CUSTOMER
	case CUSTOMER_FREIGHT_WEIGHT
	case EARNED_DISCOUNT
	case MIXED
	case RATE_SCALE
}

enum OperatingCompanyType: String
{
	case FEDEX_CARGO
	case FEDEX_CORPORATE_SERVICES
	case FEDEX_CORPORATION
	case FEDEX_CUSTOMER_INFORMATION_SYSTEMS
	case FEDEX_CUSTOM_CRITICAL
	case FEDEX_EXPRESS
	case FEDEX_FREIGHT
	case FEDEX_GROUND
	case FEDEX_KINKOS
	case FEDEX_OFFICE
	case FEDEX_SERVICES
	case FEDEX_TRADE_NETWORKS
}

enum SpecialRatingAppliedType: String
{
	case FEDEX_ONE_RATE
	case FIXED_FUEL_SURCHARGE
	case IMPORT_PRICING
}

enum RateDimensionalDivisorType: String
{
	case COUNTRY
	case CUSTOMER
	case OTHER
	case PRODUCT
	case WAIVED
}

enum WeightUnits: String
{
	case KG
	case LB
}

enum SurchargeType: String
{
	case ADDITIONAL_HANDLING
	case ANCILLARY_FEE
	case APPOINTMENT_DELIVERY
	case BROKER_SELECT_OPTION
	case CANADIAN_DESTINATION
	case CLEARANCE_ENTRY_FEE
	case COD
	case CUT_FLOWERS
	case DANGEROUS_GOODS
	case DELIVERY_AREA
	case DELIVERY_CONFIRMATION
	case DOCUMENTATION_FEE
	case DRY_ICE
	case EMAIL_LABEL
	case EUROPE_FIRST
	case EXCESS_VALUE
	case EXHIBITION
	case EXPORT
	case EXTRA_SURFACE_HANDLING_CHARGE
	case EXTREME_LENGTH
	case FEDEX_INTRACOUNTRY_FEES
	case FEDEX_TAG
	case FICE
	case FLATBED
	case FREIGHT_GUARANTEE
	case FREIGHT_ON_VALUE
	case FREIGHT_TO_COLLECT
	case FUEL
	case HOLD_AT_LOCATION
	case HOME_DELIVERY_APPOINTMENT
	case HOME_DELIVERY_DATE_CERTAIN
	case HOME_DELIVERY_EVENING
	case INSIDE_DELIVERY
	case INSIDE_PICKUP
	case INSURED_VALUE
	case INTERHAWAII
	case LIFTGATE_DELIVERY
	case LIFTGATE_PICKUP
	case LIMITED_ACCESS_DELIVERY
	case LIMITED_ACCESS_PICKUP
	case METRO_DELIVERY
	case METRO_PICKUP
	case NON_MACHINABLE
	case OFFSHORE
	case ON_CALL_PICKUP
	case OTHER
	case OUT_OF_DELIVERY_AREA
	case OUT_OF_PICKUP_AREA
	case OVERSIZE
	case OVER_DIMENSION
	case PIECE_COUNT_VERIFICATION
	case PRE_DELIVERY_NOTIFICATION
	case PRIORITY_ALERT
	case PROTECTION_FROM_FREEZING
	case REGIONAL_MALL_DELIVERY
	case REGIONAL_MALL_PICKUP
	case REROUTE
	case RESCHEDULE
	case RESIDENTIAL_DELIVERY
	case RESIDENTIAL_PICKUP
	case RETURN_LABEL
	case SATURDAY_DELIVERY
	case SATURDAY_PICKUP
	case SIGNATURE_OPTION
	case TARP
	case THIRD_PARTY_CONSIGNEE
	case TRANSMART_SERVICE_FEE
}

enum ServiceType: String
{
	case EUROPE_FIRST_INTERNATIONAL_PRIORITY
	case FEDEX_1_DAY_FREIGHT
	case FEDEX_2_DAY
	case FEDEX_2_DAY_AM
	case FEDEX_2_DAY_FREIGHT
	case FEDEX_3_DAY_FREIGHT
	case FEDEX_DISTANCE_DEFERRED
	case FEDEX_EXPRESS_SAVER
	case FEDEX_FIRST_FREIGHT
	case FEDEX_FREIGHT_ECONOMY
	case FEDEX_FREIGHT_PRIORITY
	case FEDEX_GROUND
	case FEDEX_NEXT_DAY_AFTERNOON
	case FEDEX_NEXT_DAY_EARLY_MORNING
	case FEDEX_NEXT_DAY_END_OF_DAY
	case FEDEX_NEXT_DAY_FREIGHT
	case FEDEX_NEXT_DAY_MID_MORNING
	case FIRST_OVERNIGHT
	case GROUND_HOME_DELIVERY
	case INTERNATIONAL_ECONOMY
	case INTERNATIONAL_ECONOMY_FREIGHT
	case INTERNATIONAL_FIRST
	case INTERNATIONAL_PRIORITY
	case INTERNATIONAL_PRIORITY_FREIGHT
	case PRIORITY_OVERNIGHT
	case SAME_DAY
	case SAME_DAY_CITY
	case SMART_POST
	case STANDARD_OVERNIGHT
}

enum PackagingType: String
{
	case FEDEX_10KG_BOX
	case FEDEX_25KG_BOX
	case FEDEX_BOX
	case FEDEX_ENVELOPE
	case FEDEX_EXTRA_LARGE_BOX
	case FEDEX_LARGE_BOX
	case FEDEX_MEDIUM_BOX
	case FEDEX_PAK
	case FEDEX_SMALL_BOX
	case FEDEX_TUBE
	case YOUR_PACKAGING
}

enum SignatureOptionType: String
{
	case ADULT = "Adult"
	case DIRECT = "Direct"
	case INDIRECT = "Indirect"
	case NO_SIGNATURE_REQUIRED = "No Signature Required"
	case SERVICE_DEFAULT = "Service Default"
	
	static let values = [ADULT.rawValue, DIRECT.rawValue, INDIRECT.rawValue, NO_SIGNATURE_REQUIRED.rawValue, SERVICE_DEFAULT.rawValue]
}

enum ReturnedRateType: String
{
	case PAYOR_ACCOUNT_PACKAGE
	case PAYOR_ACCOUNT_SHIPMENT
	case PAYOR_LIST_PACKAGE
	case PAYOR_LIST_SHIPMENT
	case PREFERRED_ACCOUNT_PACKAGE
	case PREFERRED_ACCOUNT_SHIPMENT
	case PREFERRED_LIST_PACKAGE
	case PREFERRED_LIST_SHIPMENT
}

enum TrackIdentifierType: String
{
	case BILL_OF_LADING
	case COD_RETURN_TRACKING_NUMBER
	case CUSTOMER_AUTHORIZATION_NUMBER
	case CUSTOMER_REFERENCE
	case DEPARTMENT
	case DOCUMENT_AIRWAY_BILL
	case FREE_FORM_REFERENCE
	case GROUND_INTERNATIONAL
	case GROUND_SHIPMENT_ID
	case GROUP_MPS
	case INVOICE
	case JOB_GLOBAL_TRACKING_NUMBER
	case ORDER_GLOBAL_TRACKING_NUMBER
	case ORDER_TO_PAY_NUMBER
	case OUTBOUND_LINK_TO_RETURN
	case PARTNER_CARRIER_NUMBER
	case PART_NUMBER
	case PURCHASE_ORDER
	case REROUTE_TRACKING_NUMBER
	case RETURNED_TO_SHIPPER_TRACKING_NUMBER
	case RETURN_MATERIALS_AUTHORIZATION
	case SHIPPER_REFERENCE
	case STANDARD_MPS
	case TRACKING_NUMBER_OR_DOORTAG
	case TRANSPORTATION_CONTROL_NUMBER
}

enum TrackRequestProcessingOptionType: String
{
	case INCLUDE_DETAILED_SCANS
}

enum InternationalDocumentContentType: String
{
	case DOCUMENTS_ONLY
	case NON_DOCUMENTS
}

enum GenericDefault: String
{
	case YES = "Yes"
	case NO = "No"
	
	static let values = [YES.rawValue, NO.rawValue]
}

enum LocationsSearchCriteriaType: String
{
    case ADDRESS = "Address"
    case GEOGRAPHIC_COORDINATES = "Geographic Coordinates"
    case PHONE_NUMBER = "Phone Number"
    
    static let values = [ADDRESS.rawValue, GEOGRAPHIC_COORDINATES.rawValue, PHONE_NUMBER.rawValue]
}

enum MultipleMatchesActionType: String
{
    case RETURN_ALL = "Return All"
    case RETURN_ERROR = "Return Error"
    case RETURN_FIRST = "Return First"
    
    static let values = [RETURN_ALL.rawValue, RETURN_ERROR.rawValue, RETURN_FIRST.rawValue]
}

enum LocationSortCriteriaType: String
{
    case DISTANCE = "Distance"
    case LATEST_EXPRESS_DROPOFF_TIME = "Latest Express Dropoff Time"
    case LATEST_GROUND_DROPOFF_TIME = "Latest Ground Dropoff Time"
    case LOCATION_TYPE = "Location Type"
    
    static let values = [DISTANCE.rawValue, LATEST_EXPRESS_DROPOFF_TIME.rawValue, LATEST_GROUND_DROPOFF_TIME.rawValue, LOCATION_TYPE.rawValue]
}

enum LocationSortOrderType: String
{
    case HIGHEST_TO_LOWEST
    case LOWEST_TO_HIGHEST
}

enum LocationSearchFilterType: String
{
    case EXCLUDE_LOCATIONS_OUTSIDE_COUNTRY = "Exclude Locations Outside Country"
    case EXCLUDE_LOCATIONS_OUTSIDE_STATE_OR_PROVINCE = "Exclude Locations Outside State or Province"
    case EXCLUDE_UNAVAILABLE_LOCATIONS = "Exclude Unavailable Locations"
    
    static let values = [EXCLUDE_LOCATIONS_OUTSIDE_COUNTRY.rawValue, EXCLUDE_LOCATIONS_OUTSIDE_STATE_OR_PROVINCE.rawValue, EXCLUDE_UNAVAILABLE_LOCATIONS.rawValue]
}

enum SupportedRedirectToHoldServiceType: String
{
    case FEDEX_EXPRESS
    case FEDEX_GROUND
    case FEDEX_GROUND_HOME_DELIVERY
}

enum LocationAttributesType: String
{
    case ACCEPTS_CASH = "Accepts Cash"
    case ALREADY_OPEN = "Already Open"
    case CLEARANCE_SERVICES = "Clearance Services"
    case COPY_AND_PRINT_SERVICES = "Copy and Print Services"
    case DANGEROUS_GOODS_SERVICES = "Dangerous Goods Services"
    case DIRECT_MAIL_SERVICES = "Direct Mail Services"
    case DOMESTIC_SHIPPING_SERVICES = "Domestic Shipping Services"
    case DROP_BOX = "Drop Box"
    case INTERNATIONAL_SHIPPING_SERVICES = "International Shipping Services"
    case LOCATION_IS_IN_AIRPORT = "Location is in Airport"
    case NOTARY_SERVICES = "Notary Services"
    case OBSERVES_DAY_LIGHT_SAVING_TIMES = "Observes Daylight Savings Time"
    case OPEN_TWENTY_FOUR_HOURS = "Open Twenty-Four Hours"
    case PACKAGING_SUPPLIES = "Packaging Supplies"
    case PACK_AND_SHIP = "Pack and Ship"
    case PASSPORT_PHOTO_SERVICES = "Passport Photo Services"
    case RETURNS_SERVICES = "Returns Services"
    case SIGNS_AND_BANNERS_SERVICE = "Signs and Banner Service"
    case SONY_PICTURE_STATION = "Sony Picture Station"
    
    static let values = [ACCEPTS_CASH.rawValue, ALREADY_OPEN.rawValue, CLEARANCE_SERVICES.rawValue, COPY_AND_PRINT_SERVICES.rawValue, DANGEROUS_GOODS_SERVICES.rawValue, DIRECT_MAIL_SERVICES.rawValue, DOMESTIC_SHIPPING_SERVICES.rawValue, DROP_BOX.rawValue, INTERNATIONAL_SHIPPING_SERVICES.rawValue, LOCATION_IS_IN_AIRPORT.rawValue, NOTARY_SERVICES.rawValue, OBSERVES_DAY_LIGHT_SAVING_TIMES.rawValue, OPEN_TWENTY_FOUR_HOURS.rawValue, PACKAGING_SUPPLIES.rawValue, PACK_AND_SHIP.rawValue, PASSPORT_PHOTO_SERVICES.rawValue, RETURNS_SERVICES.rawValue, SIGNS_AND_BANNERS_SERVICE.rawValue, SONY_PICTURE_STATION.rawValue]
}

enum LocationContentOptionType: String
{
    case HOLIDAYS = "Holidays"
    case LOCATION_DROPOFF_TIMES = "Location Dropoff Times"
    case MAP_URL = "Map URL"
    case TIMEZONE_OFFSET = "Timezone Offset"
    
    static let values = [HOLIDAYS.rawValue, LOCATION_DROPOFF_TIMES.rawValue, MAP_URL.rawValue, TIMEZONE_OFFSET.rawValue]
}

enum LocationTransferOfPossessionType: String
{
    case DROPOFF = "Drop Off"
    case HOLD_AT_LOCATION = "Hold at Location"
    case REDIRECT_TO_HOLD_AT_LOCATION = "Redirect to Hold at Location"
    
    static let values = [DROPOFF.rawValue, HOLD_AT_LOCATION.rawValue, REDIRECT_TO_HOLD_AT_LOCATION.rawValue]
}

enum ServiceCategoryType: String
{
    case EXPRESS_FREIGHT = "Express Freight"
    case EXPRESS_PARCEL = "Express Parcel"
    case GROUND_HOME_DELIVERY = "Ground Home Delivery"
    
    static let values = [EXPRESS_FREIGHT.rawValue, EXPRESS_PARCEL.rawValue, GROUND_HOME_DELIVERY.rawValue]
}
