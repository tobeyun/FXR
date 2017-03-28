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
		let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		
		_highestSeverity = NotificationSeverityType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|HighestSeverity|").map{ $0.components(separatedBy: "|").last! }[safe: 0]!)!
		
		_notifications = stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Severity|").map{ fNotification(severity: NotificationSeverityType(rawValue: $0.components(separatedBy: "|").last!), source: nil, code: nil, message: nil, localizedMessage: nil, messageParameters: nil) }
		
		// notification array has been created, now fill
		//_notifications = _notifications.map{ _ in }
		
		_transactionDetail = TransactionDetail(
			customerTransactionId: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|TransactionDetail|CustomerTransactionId|").map{ $0.components(separatedBy: "|").last! }[safe: 0],
			localization: Localization(
				languageCode: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|TransactionDetail|Localization|LanguageCode|").map{ $0.components(separatedBy: "|").last! }[safe: 0] ?? "",
				localeCode: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|TransactionDetail|Localization|LocaleCode|").map{ $0.components(separatedBy: "|").last! }[safe: 0]
			)
		)
		
		_version = VersionId()
		
		if (_highestSeverity == NotificationSeverityType.FAILURE)
		{
			_rateReplyDetails = nil
		}
		else
		{
			_rateReplyDetails = [RateReplyDetail(
				serviceType: ServiceType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|ServiceType").map{ $0.components(separatedBy: "|").last! }[0])!,
				packagingType: PackagingType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|PackagingType").map{ $0.components(separatedBy: "|").last! }[0])!,
				appliedOptions: [nil], //ServiceOptionType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|AppliedOptions").map{ $0.components(separatedBy: "|").last! }[0])!,
				appliedSubOptions: nil, //ServiceSubOptionDetail(
				deliveryStation: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|").map{ $0.components(separatedBy: "|").last! }[0],
				deliveryDayOfWeek: DayOfWeekType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|DeliveryDayOfWeek").map{ $0.components(separatedBy: "|").last! }[0])!,
				deliveryTimestamp: dateFormatter.date(from: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|DeliveryTimestamp").map{ $0.components(separatedBy: "|").last! }[safe: 0]!),
				commitDetails: [nil],
	//			CommitDetail(
	//				serviceType: ServiceType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|CommitDetails:ServiceType").map{ $0.components(separatedBy: "|").last! }[0])!,
	//				commitTimeStamp: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|CommitDetails:CommitTimeStamp").map{ $0.components(separatedBy: "|").last! }[0],
	//				dayOfWeek: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|CommitDetails:DayOfWeek").map{ $0.components(separatedBy: "|").last! }[0],
	//				destinationServiceArea: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|CommitDetails:DestinationServiceArea").map{ $0.components(separatedBy: "|").last! }[0],
	//				brokerToDestinationDays: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|CommitDetails:BrokerToDestinationDays").map{ $0.components(separatedBy: "|").last! }[0],
	//				documentContent: InternationalDocumentContentType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|CommitDetails:DocumentContent").map{ $0.components(separatedBy: "|").last! }[0])!
	//			),
				destinationAirportId: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|DestinationAirportId").map{ $0.components(separatedBy: "|").last! }[0],
				ineligibleForMoneyBackGuarantee: nil, //stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|IneligibleForMoneyBackGuarantee").map{ $0.components(separatedBy: "|").last! }[0],
				originServiceArea: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|OriginServiceArea").map{ $0.components(separatedBy: "|").last! }[0],
				destinationServiceArea: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|DestinationServiceArea").map{ $0.components(separatedBy: "|").last! }[0],
				transitTime: TransitTimeType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|TransitTime").map{ $0.components(separatedBy: "|").last! }[safe: 0] ?? ""),
				maximumTransitTime: TransitTimeType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|MaximumTransitTime").map{ $0.components(separatedBy: "|").last!  }[safe: 0] ?? ""),
				signatureOption: SignatureOptionType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|SignatureOption").map{ $0.components(separatedBy: "|").last! }[0])!,
				actualRateType: ReturnedRateType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|ActualRateType").map{ $0.components(separatedBy: "|").last! }[0])!,
				ratedShipmentDetails: [nil]
				/*RatedShipmentDetail(
					effectiveNetDiscount: Money(
						currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|EffectiveNetDiscount:Currency").map{ $0.components(separatedBy: "|").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|EffectiveNetDiscount:Amount").map{ $0.components(separatedBy: "|").last! }[0]
					),
					adjustedCodCollectionAmount: Money(
						currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|AdjustedCodCollectionAmount:Currency").map{ $0.components(separatedBy: "|").last! }[0],
						amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|AdjustedCodCollectionAmount:Amount").map{ $0.components(separatedBy: "|").last! }[0]
					),
					shipmentRateDetail: ShipmentRateDetail(
						rateType: ReturnedRateType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RateType").map{ $0.components(separatedBy: "|").last! }[0])!,
						rateScale: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RateScale").map{ $0.components(separatedBy: "|").last! }[0],
						rateZone: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RateZone").map{ $0.components(separatedBy: "|").last! }[0],
						pricingCode: PricingCodeType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|PricingCode").map{ $0.components(separatedBy: "|").last! }[0])!,
						ratedWeightMethod: RatedWeightMethod(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RatedWeightMethod").map{ $0.components(separatedBy: "|").last! }[0])!,
						minimumChargeType: MinimumChargeType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|MinimumChargeType").map{ $0.components(separatedBy: "|").last! }[0])!,
						currencyExchangeRate: CurrencyExchangeRate(
							fromCurrency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|CurrencyExchanceRate:FromCurrency").map{ $0.components(separatedBy: "|").last! }[0],
							intoCurrency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|CurrencyExchangeRate:IntoCurrency").map{ $0.components(separatedBy: "|").last! }[0],
							rate: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|CurrencyExchangeRate:Rate").map{ $0.components(separatedBy: "|").last! }[0]
						),
						specialRatingApplied: SpecialRatingAppliedType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|SpecialRatingApplied").map{ $0.components(separatedBy: "|").last! }[0])!,
						dimDivisor: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|DimDivisor").map{ $0.components(separatedBy: "|").last! }[0],
						dimDivisorType: RateDimensionalDivisorType(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|DimDivisorType").map{ $0.components(separatedBy: "|").last! }[0])!,
						fuelSurchargePercent: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|FuelSurchargePercent").map{ $0.components(separatedBy: "|").last! }[0],
						totalBillingWeight: Weight(
							units: WeightUnits(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBillingWeight:Units").map{ $0.components(separatedBy: "|").last! }[0])!,
							value: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBillingWeight:Value").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalDimWeight: Weight(
							units: WeightUnits(rawValue: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDimWeight:Units").map{ $0.components(separatedBy: "|").last! }[0])!,
							value: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDimWeight:Value").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalBaseCharge: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBaseCharge:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBaseCharge:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalFreightDiscounts: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalFreightDiscounts:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalFreightDiscounts:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalNetFreight: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFreight:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFreight:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalSurcharges: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalSurcharges:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalSurcharges:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalNetFedExCharge: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFedExCharge:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFedExCharge:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalTaxes: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalTaxes:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalTaxes.Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalNetCharge: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetCharge:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalnetCharge:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalRebates: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalRebates:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalRebates:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalDutiesAndTaxes: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesAndTaxes:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesAndTaxes:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalAncillaryFeesAndTaxes: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalAncillaryFeesAndTaxes:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalAncillaryFeesAndTaxes:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalDutiesTaxesAndFees: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesTaxesAndFees:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesTaxesAndFees:Amount").map{ $0.components(separatedBy: "|").last! }[0]
						),
						totalNetChargeWithDutiesAndTaxes: Money(
							currency: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetChargeWithDutiesAndTaxes:Currency").map{ $0.components(separatedBy: "|").last! }[0],
							amount: stack.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetChargeWithDutiesAndTaxes:Amount").map{ $0.components(separatedBy: "|").last! }[0]
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
				)*/
			)]
		}
	}
}

//extension fNotification
//{
//	init(severity: NotificationSeverityType?, source: String?, code: String?, message: String?, localizedMessage: String?, messageParameters: [NotificationParameter]?)
//	{
//		_severity = severity
//		_source = source
//		_code = code
//		_message = message
//		_localizedMessage = localizedMessage
//		_messageParameters = messageParameters
//		
//		messageParameters: NotificationParameter(
//		id: array.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Id").map{ $0.components(separatedBy: "|").last! }[safe: 0],
//			value: array.find("SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Value").map{ $0.components(separatedBy: "|").last! }[safe: 0])
//	}
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Severity:WARNING"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Source:crs"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Code:872"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Message:Rating is temporarily unavailable for one or more services:\nFEDEX_2_DAY_AM; FEDEX_2_DAY; FEDEX_EXPRESS_SAVER; ; ; ; ; ; ; ; . Please try again later. "
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|LocalizedMessage:Rating is temporarily unavailable for one or more services:\nFEDEX_2_DAY_AM; FEDEX_2_DAY; FEDEX_EXPRESS_SAVER; ; ; ; ; ; ; ; . Please try again later. "
//		
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Id:SERVICE_TYPE_1"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Value:FEDEX_2_DAY_AM"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Id:SERVICE_TYPE_2"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Value:FEDEX_2_DAY"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Id:SERVICE_TYPE_3"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|MessageParameters:Value:FEDEX_EXPRESS_SAVER"
//		
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Severity:NOTE"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Source:crs"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Code:977"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|Message:The shipdate has been changed for commitment purposes.\n"
//		"SOAP-ENV:Envelope|SOAP-ENV:Body|RateReply|Notifications|LocalizedMessage:The shipdate has been changed for commitment purposes.\n"
//}
