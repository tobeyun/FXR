//
//  WsdlExtensions.swift
//  FXR
//
//  Created by Tobey Unruh on 3/26/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Foundation

extension RateReply
{
	init(stack: Stack<String>)
	{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		
		_highestSeverity = NotificationSeverityType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:HighestSeverity").map{ $0.components(separatedBy: ":").last! }[safe: 0]!)!
		
		_notifications = fNotification(
			severity: NotificationSeverityType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:Notifications:Severity").map{ $0.components(separatedBy: ":").last! }[safe: 0]!)!,
			source: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:Notifications:Source").map{ $0.components(separatedBy: ":").last! }[safe: 0],
			code: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:Notifications:Code").map{ $0.components(separatedBy: ":").last! }[safe: 0],
			message: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:Notifications:Message").map{ $0.components(separatedBy: ":").last! }[safe: 0],
			localizedMessage: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:Notifications:LocalizedMessage").map{ $0.components(separatedBy: ":").last! }[safe: 0],
			messageParameters: NotificationParameter(
				id: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:Notifications:MessageParameters:Id").map{ $0.components(separatedBy: ":").last! }[safe: 0],
				value: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:Notifications:MessageParameters:Value").map{ $0.components(separatedBy: ":").last! }[safe: 0])
		)
		
		_transactionDetail = TransactionDetail(
			customerTransactionId: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:TransactionDetail:CustomerTransactionId").map{ $0.components(separatedBy: ":").last! }[safe: 0],
			localization: Localization(
				languageCode: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:TransactionDetail:Localization:LanguageCode").map{ $0.components(separatedBy: ":").last! }[safe: 0] ?? "",
				localeCode: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:TransactionDetail:Localization:LocaleCode").map{ $0.components(separatedBy: ":").last! }[safe: 0]
			)
		)
		
		_version = VersionId()
		
		_rateReplyDetails = RateReplyDetail(
			serviceType: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:ServiceType").map{ ServiceType(rawValue: $0.components(separatedBy: ":").last!) },
			packagingType: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:PackagingType").map{ PackagingType(rawValue: $0.components(separatedBy: ":").last!) },
			appliedOptions: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:AppliedOptions").map{ ServiceOptionType(rawValue: $0.components(separatedBy: ":").last!) },
			appliedSubOptions: ServiceSubOptionDetail(
				freightGuarantee: <#T##FreightGuaranteeType#>,
				smartPostHubId: <#T##String#>,
				smartPostIndicia: <#T##SmartPostIndiciaType#>
			),
			deliveryStation: nil,
			deliveryDayOfWeek: nil,
			deliveryTimestamp: nil,
			commitDetails: nil,
			destinationAirportId: nil,
			ineligibleForMoneyBackGuarantee: nil,
			originServiceArea: nil,
			destinationServiceArea: nil,
			transitTime: nil,
			maximumTransitTime: nil,
			signatureOption: nil,
			actualRateType: nil,
			ratedShipmentDetails: nil
		)
		
		/*let rateReplyDetails = RateReplyDetail(
			serviceType: ServiceType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:ServiceType").map{ $0.components(separatedBy: ":").last! }[0])!,
			packagingType: PackagingType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:PackagingType").map{ $0.components(separatedBy: ":").last! }[0])!,
			appliedOptions: ServiceOptionType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:AppliedOptions").map{ $0.components(separatedBy: ":").last! }[0])!,
			appliedSubOptions: ServiceSubOptionDetail(
				freightGuarantee: FreightGuaranteeType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:AppliedSubOptions:FreightGuarantee").map{ $0.components(separatedBy: ":").last! }[0])!,
				smartPostHubId: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:AppliedSubOptions:SmartPostHubId").map{ $0.components(separatedBy: ":").last! }[0],
				smartPostIndicia: SmartPostIndiciaType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:AppliedSubOptions:SmartPostIndicia").map{ $0.components(separatedBy: ":").last! }[0])!
			),
			deliveryStation: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:").map{ $0.components(separatedBy: ":").last! }[0],
			deliveryDayOfWeek: DayOfWeekType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:DeliveryDayOfWeek").map{ $0.components(separatedBy: ":").last! }[0])!,
			deliveryTimestamp: dateFormatter.dateFromString(stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:DeliveryTimeStamp").map{ $0.components(separatedBy: ":").last! }[0])!,
			commitDetails: CommitDetail(
				serviceType: ServiceType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:CommitDetails:ServiceType").map{ $0.components(separatedBy: ":").last! }[0])!,
				commitTimeStamp: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:CommitDetails:CommitTimeStamp").map{ $0.components(separatedBy: ":").last! }[0],
				dayOfWeek: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:CommitDetails:DayOfWeek").map{ $0.components(separatedBy: ":").last! }[0],
				destinationServiceArea: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:CommitDetails:DestinationServiceArea").map{ $0.components(separatedBy: ":").last! }[0],
				brokerToDestinationDays: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:CommitDetails:BrokerToDestinationDays").map{ $0.components(separatedBy: ":").last! }[0],
				documentContent: InternationalDocumentContentType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:CommitDetails:DocumentContent").map{ $0.components(separatedBy: ":").last! }[0])!
			),
			destinationAirportId: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:DestinationAirportId").map{ $0.components(separatedBy: ":").last! }[0],
			ineligibleForMoneyBackGuarantee: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:IneligibleForMoneyBackGuarantee").map{ $0.components(separatedBy: ":").last! }[0],
			originServiceArea: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:OriginServiceArea").map{ $0.components(separatedBy: ":").last! }[0],
			destinationServiceArea: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:DestinationServiceArea").map{ $0.components(separatedBy: ":").last! }[0],
			transitTime: TransitTimeType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:TransitTime").map{ $0.components(separatedBy: ":").last! }[0])!,
			maximumTransitTime: TransitTimeType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:MaximumTransitTime").map{ $0.components(separatedBy: ":").last! }[0])!,
			signatureOption: SignatureOptionType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:SignatureOption").map{ $0.components(separatedBy: ":").last! }[0])!,
			actualRateType: ReturnedRateType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:ActualRateType").map{ $0.components(separatedBy: ":").last! }[0])!,
			ratedShipmentDetails: RatedShipmentDetail(
				effectiveNetDiscount: Money(
					currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:EffectiveNetDiscount:Currency").map{ $0.components(separatedBy: ":").last! }[0],
					amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:EffectiveNetDiscount:Amount").map{ $0.components(separatedBy: ":").last! }[0]
				),
				adjustedCodCollectionAmount: Money(
					currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:AdjustedCodCollectionAmount:Currency").map{ $0.components(separatedBy: ":").last! }[0],
					amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:AdjustedCodCollectionAmount:Amount").map{ $0.components(separatedBy: ":").last! }[0]
				),
				shipmentRateDetail: ShipmentRateDetail(
					rateType: ReturnedRateType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:RateType").map{ $0.components(separatedBy: ":").last! }[0])!,
					rateScale: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:RateScale").map{ $0.components(separatedBy: ":").last! }[0],
					rateZone: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:RateZone").map{ $0.components(separatedBy: ":").last! }[0],
					pricingCode: PricingCodeType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:PricingCode").map{ $0.components(separatedBy: ":").last! }[0])!,
					ratedWeightMethod: RatedWeightMethod(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:RatedWeightMethod").map{ $0.components(separatedBy: ":").last! }[0])!,
					minimumChargeType: MinimumChargeType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:MinimumChargeType").map{ $0.components(separatedBy: ":").last! }[0])!,
					currencyExchangeRate: CurrencyExchangeRate(
						fromCurrency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:CurrencyExchanceRate:FromCurrency").map{ $0.components(separatedBy: ":").last! }[0],
						intoCurrency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:CurrencyExchangeRate:IntoCurrency").map{ $0.components(separatedBy: ":").last! }[0],
						rate: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:CurrencyExchangeRate:Rate").map{ $0.components(separatedBy: ":").last! }[0]
					),
					specialRatingApplied: SpecialRatingAppliedType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:SpecialRatingApplied").map{ $0.components(separatedBy: ":").last! }[0])!,
					dimDivisor: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:DimDivisor").map{ $0.components(separatedBy: ":").last! }[0],
					dimDivisorType: RateDimensionalDivisorType(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:DimDivisorType").map{ $0.components(separatedBy: ":").last! }[0])!,
					fuelSurchargePercent: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:FuelSurchargePercent").map{ $0.components(separatedBy: ":").last! }[0],
					totalBillingWeight: Weight(
						units: WeightUnits(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalBillingWeight:Units").map{ $0.components(separatedBy: ":").last! }[0])!,
						value: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalBillingWeight:Value").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalDimWeight: Weight(
						units: WeightUnits(rawValue: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalDimWeight:Units").map{ $0.components(separatedBy: ":").last! }[0])!,
						value: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalDimWeight:Value").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalBaseCharge: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalBaseCharge:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalBaseCharge:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalFreightDiscounts: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalFreightDiscounts:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalFreightDiscounts:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalNetFreight: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalNetFreight:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalNetFreight:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalSurcharges: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalSurcharges:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalSurcharges:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalNetFedExCharge: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalNetFedExCharge:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalNetFedExCharge:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalTaxes: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalTaxes:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalTaxes.Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalNetCharge: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalNetCharge:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalnetCharge:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalRebates: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalRebates:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalRebates:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalDutiesAndTaxes: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalDutiesAndTaxes:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalDutiesAndTaxes:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalAncillaryFeesAndTaxes: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalAncillaryFeesAndTaxes:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalAncillaryFeesAndTaxes:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalDutiesTaxesAndFees: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalDutiesTaxesAndFees:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalDutiesTaxesAndFees:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					totalNetChargeWithDutiesAndTaxes: Money(
						currency: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalNetChargeWithDutiesAndTaxes:Currency").map{ $0.components(separatedBy: ":").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope:SOAP-ENV:Body:RateReply:RateReplyDetails:RatedShipmentDetails:ShipmentRateDetail:TotalNetChargeWithDutiesAndTaxes:Amount").map{ $0.components(separatedBy: ":").last! }[0]
					),
					shipmentLegRateDetails: ShipmentLegRateDetail(
						legDescription: <#T##String#>,
						legOrigin: Address(
							streetLines: <#T##String?#>,
							city: <#T##String?#>,
							stateOrProvinceCode: <#T##String?#>,
							postalCode: <#T##String?#>,
							urbanizationCode: <#T##String?#>,
							countryCode: <#T##String?#>,
							countryName: <#T##String?#>,
							residential: <#T##Bool?#>
						),
						legOriginLocationId: <#T##String#>,
						legDestination: Address(
							streetLines: <#T##String?#>,
							city: <#T##String?#>,
							stateOrProvinceCode: <#T##String?#>,
							postalCode: <#T##String?#>,
							urbanizationCode: <#T##String?#>,
							countryCode: <#T##String?#>,
							countryName: <#T##String?#>,
							residential: <#T##Bool?#>
						),
						legDestinationLocationId: <#T##String#>,
						rateType: <#T##ReturnedRateType#>,
						rateScale: <#T##String#>,
						rateZone: <#T##String#>,
						pricingCode: <#T##PricingCodeType#>,
						ratedWeightMethod: <#T##RatedWeightMethod#>,
						minimumChargeType: <#T##MinimumChargeType#>,
						currencyExchangeRate: <#T##CurrencyExchangeRate#>,
						specialRatingApplied: <#T##SpecialRatingAppliedType#>,
						dimDivisor: <#T##UInt#>,
						dimDivisorType: <#T##RateDimensionalDivisorType#>,
						fuelSurchargePercent: <#T##NSDecimalNumber#>,
						totalBillingWeight: Weight(
							units: WeightUnits(rawValue: ),
							value: <#T##NSDecimalNumber#>
						),
						totalDimWeight: Weight(
							units: WeightUnits(rawValue: ),
							value: <#T##NSDecimalNumber#>
						),
						totalBaseCharge: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalFreightDiscounts: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalNetFreight: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalSurcharges: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalNetFedExCharge: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalTaxes: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalNetCharge: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalRebates: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalDutiesAndTaxes: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalNetChargeWithDutiesAndTaxes: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						freightRateDetail: FreightRateDetail(
							quoteNumber: <#T##String#>,
							quoteType: FreightRateQuoteType(rawValue: ),
							baseChargeCalculation: FreightBaseChargeCalculationType(rawValue: ),
							baseCharges: FreightBaseCharge(
								freightClass: <#T##FreightClassType#>,
								ratedAsClass: <#T##FreightClassType#>,
								nmfcCode: <#T##String#>,
								description: <#T##String#>,
								weight: Weight(
									units: WeightUnits(rawValue: ),
									value: <#T##NSDecimalNumber#>
								),
								chargeRate: Money(
									currency: <#T##String#>,
									amount: <#T##NSDecimalNumber#>
								),
								chargeBasis: <#T##FreightChargeBasisType#>,
								extendedAmount: Money(
									currency: <#T##String#>,
									amount: <#T##NSDecimalNumber#>
								)
							),
							notations: FreightRateNotation(
								code: <#T##String#>,
								description: <#T##String#>
							)
						),
						freightDiscounts: <#T##RateDiscount#>,
						rebates: <#T##Rebate#>, surcharges: <#T##Surcharge#>,
						taxes: <#T##Tax#>, dutiesAndTaxes: <#T##EdtCommodityTax#>,
						variableHandlingCharges: <#T##VariableHandlingCharges#>,
						totalVariableHandlingCharges: <#T##VariableHandlingCharges#>
					),
					freightRateDetail: FreightRateDetail(
						quoteNumber: <#T##String#>,
						quoteType: <#T##FreightRateQuoteType#>,
						baseChargeCalculation: <#T##FreightBaseChargeCalculationType#>,
						baseCharges: <#T##FreightBaseCharge#>,
						notations: <#T##FreightRateNotation#>
					),
					freightDiscounts: RateDiscount(
						rateDiscountType: <#T##RateDiscountType#>,
						description: <#T##String#>,
						amount: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						percent: <#T##NSDecimalNumber#>
					),
					rebates: Rebate(
						rebateType: <#T##RebateType#>,
						description: <#T##String#>,
						amount: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						percent: <#T##NSDecimalNumber#>
					),
					surcharges: Surcharge(
						surchargeType: <#T##SurchargeType#>,
						level: <#T##SurchargeLevelType#>,
						description: <#T##String#>,
						amount: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						)
					),
					taxes: Tax(
						taxType: <#T##TaxType#>,
						description: <#T##String#>,
						amount: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						)
					),
					dutiesAndTaxes: <#T##EdtCommodityTax#>,
					ancillaryFeesAndTaxes: <#T##AncillaryFeeAndTax#>,
					variableHandlingCharges: <#T##VariableHandlingCharges#>,
					totalVariableHandlingCharges: <#T##VariableHandlingCharges#>
				),
				ratedPackages: RatedPackageDetail(
					trackingIds: <#T##TrackingId#>,
					groupNumber: <#T##UInt#>,
					effectiveNetDiscount: Money(
						currency: <#T##String#>,
						amount: <#T##NSDecimalNumber#>
					),
					adjustedCodCollectionAmount: Money(
						currency: <#T##String#>,
						amount: <#T##NSDecimalNumber#>
					),
					oversizeClass: <#T##OversizeClassType#>,
					packageRateDetail: PackageRateDetail(
						rateType: <#T##ReturnedRateType#>,
						ratedWeightMethod: <#T##RatedWeightMethod#>,
						minimumChargeType: <#T##MinimumChargeType#>,
						billingWeight: Weight(
							units: WeightUnits(rawValue: ),
							value: <#T##NSDecimalNumber#>
						),
						dimWeight: Weight(
							units: WeightUnits(rawValue: ),
							value: <#T##NSDecimalNumber#>
						),
						oversizeWeight: Weight(
							units: WeightUnits(rawValue: ),
							value: <#T##NSDecimalNumber#>
						),
						baseCharge: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalFreightDiscounts: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						netFreight: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalSurcharges: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						netFedExCharge: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalTaxes: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						netCharge: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						totalRebates: Money(
							currency: <#T##String#>,
							amount: <#T##NSDecimalNumber#>
						),
						freightDiscounts: RateDiscount(
							rateDiscountType: <#T##RateDiscountType#>,
							description: <#T##String#>,
							amount: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							),
							percent: <#T##NSDecimalNumber#>
						),
						rebates: Rebate(
							rebateType: <#T##RebateType#>,
							description: <#T##String#>,
							amount: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							),
							percent: <#T##NSDecimalNumber#>
						),
						surcharges: Surcharge(
							surchargeType: <#T##SurchargeType#>,
							level: <#T##SurchargeLevelType#>,
							description: <#T##String#>,
							amount: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							)
						),
						taxes: Tax(
							taxType: <#T##TaxType#>,
							description: <#T##String#>,
							amount: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							)
						),
						variableHandlingCharges: VariableHandlingCharges(
							variableHandlingCharge: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							),
							fixedVariableHandlingCharge: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							),
							percentVariableHandlingCharge: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							),
							totalCustomerCharge: Money(
								currency: <#T##String#>,
								amount: <#T##NSDecimalNumber#>
							)
						)
					)
				)
			)
		)*/
	}
}
