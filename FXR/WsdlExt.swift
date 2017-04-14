//
//  WsdlExtensions.swift
//  FXR
//
//  Created by Tobey Unruh on 3/26/17.
//  Copyright © 2017 Tobey Unruh. All rights reserved.
//

import Foundation

//extension RateReply
//{
//	init(_ stack: Stack<ValuePath>)
//	{
//		var start = Date()
//		
//		let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//		_highestSeverity = NotificationSeverityType(rawValue: stack.find("RateReply|HighestSeverity")[safe: 0]!.value)!
//		
//		_notifications = stack.find("RateReply|Notifications|Severity").enumerated().map{ (index, element) -> fNotification in
//			let notification = fNotification(
//				severity: NotificationSeverityType(rawValue: element.value ),
//				source: stack.find("RateReply|Notifications|Source")[safe: index]?.value ?? "",
//				code: stack.find("RateReply|Notifications|Code")[safe: index]?.value ?? "",
//				message: stack.find("RateReply|Notifications|Message")[safe: index]?.value ?? "",
//				localizedMessage: stack.find("RateReply|Notifications|LocalizedMessage")[safe: index]?.value ?? "",
//				messageParameters: stack.find("RateReply|Notifications|MessageParameters").enumerated().map{ (i, e) -> NotificationParameter in
//					let parameter = NotificationParameter(
//						id: stack.find("RateReply|Notifications|MessageParameters")[safe: i]!.value,
//						value: stack.find("RateReply|Notifications|MessageParameters")[safe: i]!.value
//					)
//					
//					return parameter
//				}
//			)
//			
//			return notification
//		}
//		
//		_transactionDetail = TransactionDetail(
//			customerTransactionId: stack.find("RateReply|TransactionDetail|CustomerTransactionId").map{ $0.value }[safe: 0],
//			localization: Localization(
//				languageCode: stack.find("RateReply|TransactionDetail|Localization|LanguageCode").map{ $0.value }[safe: 0] ?? "",
//				localeCode: stack.find("RateReply|TransactionDetail|Localization|LocaleCode").map{ $0.value }[safe: 0] ?? ""
//			)
//		)
//		
//		_version = VersionId()
//		
//		print("Init Time PRE-RATE: \(Date().timeIntervalSince(start))")
//		start = Date()
//		
//		if (_highestSeverity == NotificationSeverityType.FAILURE)
//		{
//			_rateReplyDetails = nil
//		}
//		else
//		{
//			_rateReplyDetails = stack.find("RateReply|RateReplyDetails|ServiceType").enumerated().map{ (index, element) -> RateReplyDetail in
//				let rateReplyDetail = RateReplyDetail(
//					serviceType: ServiceType(rawValue: stack.find("RateReply|RateReplyDetails|ServiceType")[safe: index]?.value ?? ""),
//					packagingType: PackagingType(rawValue: stack.find("RateReply|RateReplyDetails|PackagingType")[safe: index]?.value ?? ""),
//					appliedOptions: stack.find("RateReply|RateReplyDetails|AppliedOptions").enumerated().map{ (i, e) -> ServiceOptionType in
//						let appliedOption = ServiceOptionType(rawValue: element.value)
//
//						return appliedOption!
//					},
//					appliedSubOptions: ServiceSubOptionDetail(
//						freightGuarantee: FreightGuaranteeType(rawValue: stack.find("RateReply|RateReplyDetails|AppliedSubOptions|FreightGuarantee")[safe: index]?.value ?? ""),
//						smartPostHubId: stack.find("RateReply|RateReplyDetails|AppliedSubOptions|SmartPostHubId")[safe: index]?.value ?? "",
//						smartPostIndicia: SmartPostIndiciaType(rawValue: stack.find("RateReply|RateReplyDetails|AppliedSubOptions|SmartPostIndicia")[safe: index]?.value ?? "")
//					),
//					deliveryStation: stack.find("RateReply|RateReplyDetails|DeliveryStation")[safe: index]?.value ?? "",
//					deliveryDayOfWeek: DayOfWeekType(rawValue: stack.find("RateReply|RateReplyDetails|DeliveryDayOfWeek")[safe: index]?.value ?? ""),
//					deliveryTimestamp: dateFormatter.date(from: stack.find("RateReply|RateReplyDetails|DeliveryTimestamp")[safe: index]?.value ?? ""),
//					commitDetails: stack.find("RateReply|RateReplyDetails|CommitDetails|ServiceType").enumerated().map{ (i, e) -> CommitDetail in
//						let commitDetail = CommitDetail(
//							serviceType: ServiceType(rawValue: stack.find("RateReply|RateReplyDetails|CommitDetails|ServiceType")[safe: index]?.value ?? ""),
//							commitTimeStamp: dateFormatter.date(from: stack.find("RateReply|RateReplyDetails|CommitDetails|CommitTimestamp")[safe: index]?.value ?? ""),
//							dayOfWeek: stack.find("RateReply|RateReplyDetails|CommitDetails|DayOfWeek")[safe: index]?.value ?? "",
//							destinationServiceArea: stack.find("RateReply|RateReplyDetails|CommitDetails|DestinationServiceArea")[safe: index]?.value ?? "",
//							brokerToDestinationDays: Int(stack.find("RateReply|RateReplyDetails|CommitDetails|BrokerToDestinationDays")[safe: index]?.value ?? ""),
//							documentContent: InternationalDocumentContentType(rawValue: stack.find("RateReply|RateReplyDetails|CommitDetails|DocumentContent")[safe: index]?.value ?? "")
//						)
//
//						return commitDetail
//					},
//					destinationAirportId: stack.find("RateReply|RateReplyDetails|DestinationAirportId")[safe: index]?.value ?? "",
//					ineligibleForMoneyBackGuarantee: (stack.find("RateReply|RateReplyDetails|IneligibleForMoneyBackGuarantee")[safe: index]?.value)! == "TRUE",
//					originServiceArea: stack.find("RateReply|RateReplyDetails|OriginServiceArea")[safe: index]?.value ?? "",
//					destinationServiceArea: stack.find("RateReply|RateReplyDetails|DestinationServiceArea")[safe: index]?.value ?? "",
//					transitTime: TransitTimeType(rawValue: stack.find("RateReply|RateReplyDetails|TransitTime").map{ $0.value }[safe: index] ?? ""),
//					maximumTransitTime: TransitTimeType(rawValue: stack.find("RateReply|RateReplyDetails|MaximumTransitTime").map{ $0.value }[safe: index] ?? ""),
//					signatureOption: SignatureOptionType(rawValue: stack.find("RateReply|RateReplyDetails|SignatureOption")[safe: index]?.value ?? ""),
//					actualRateType: ReturnedRateType(rawValue: stack.find("RateReply|RateReplyDetails|ActualRateType")[safe: index]?.value ?? ""),
//					ratedShipmentDetails: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RateType").enumerated().map{ (i, e) -> RatedShipmentDetail in
//						let ratedShipmentDetail = RatedShipmentDetail(
//							effectiveNetDiscount: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|EffectiveNetDiscount|Currency")[safe: index]?.value ?? "",
//								amount: NSDecimalNumber(string: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|EffectiveNetDiscount|Amount")[safe: index]?.value ?? "0")
//							),
//							adjustedCodCollectionAmount: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|AdjustedCodCollectionAmount|Currency")[safe: index]?.value ?? "",
//								amount: NSDecimalNumber(string: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|AdjustedCodCollectionAmount|Amount")[safe: index]?.value ?? "0")
//							),
//							shipmentRateDetail: nil,
//							ratedPackages: nil
//						)
//		
//						return ratedShipmentDetail
//					}
//				)
//				
//				return rateReplyDetail
//			}
//		}
//		
//		print("Init Time Final: \(Date().timeIntervalSince(start))")
//	}
//}


//				
//					/*RatedShipmentDetail(
//
//
//						shipmentRateDetail: ShipmentRateDetail(
//							rateType: ReturnedRateType(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RateType")[safe: index]?.value ?? "")!,
//							rateScale: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RateScale")[safe: index]?.value ?? "",
//							rateZone: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RateZone")[safe: index]?.value ?? "",
//							pricingCode: PricingCodeType(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|PricingCode")[safe: index]?.value ?? "")!,
//							ratedWeightMethod: RatedWeightMethod(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|RatedWeightMethod")[safe: index]?.value ?? "")!,
//							minimumChargeType: MinimumChargeType(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|MinimumChargeType")[safe: index]?.value ?? "")!,
//							currencyExchangeRate: CurrencyExchangeRate(
//								fromCurrency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|CurrencyExchanceRate|FromCurrency")[safe: index]?.value ?? "",
//								intoCurrency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|CurrencyExchangeRate|IntoCurrency")[safe: index]?.value ?? "",
//								rate: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|CurrencyExchangeRate:Rate")[safe: index]?.value ?? ""
//							),
//							specialRatingApplied: SpecialRatingAppliedType(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|SpecialRatingApplied")[safe: index]?.value ?? "")!,
//							dimDivisor: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|DimDivisor")[safe: index]?.value ?? "",
//							dimDivisorType: RateDimensionalDivisorType(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|DimDivisorType")[safe: index]?.value ?? "")!,
//							fuelSurchargePercent: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|FuelSurchargePercent")[safe: index]?.value ?? "",
//							totalBillingWeight: Weight(
//								units: WeightUnits(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBillingWeight:Units")[safe: index]?.value ?? "")!,
//								value: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBillingWeight|Value")[safe: index]?.value ?? ""
//							),
//							totalDimWeight: Weight(
//								units: WeightUnits(rawValue: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDimWeight:Units")[safe: index]?.value ?? "")!,
//								value: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDimWeight|Value")[safe: index]?.value ?? ""
//							),
//							totalBaseCharge: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBaseCharge|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalBaseCharge|Amount")[safe: index]?.value ?? ""
//							),
//							totalFreightDiscounts: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalFreightDiscounts|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalFreightDiscounts|Amount")[safe: index]?.value ?? ""
//							),
//							totalNetFreight: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFreight|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFreight|Amount")[safe: index]?.value ?? ""
//							),
//							totalSurcharges: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalSurcharges|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalSurcharges|Amount")[safe: index]?.value ?? ""
//							),
//							totalNetFedExCharge: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFedExCharge|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetFedExCharge|Amount")[safe: index]?.value ?? ""
//							),
//							totalTaxes: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalTaxes|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalTaxes.Amount")[safe: index]?.value ?? ""
//							),
//							totalNetCharge: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetCharge|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalnetCharge|Amount")[safe: index]?.value ?? ""
//							),
//							totalRebates: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalRebates|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalRebates|Amount")[safe: index]?.value ?? ""
//							),
//							totalDutiesAndTaxes: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesAndTaxes|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesAndTaxes|Amount")[safe: index]?.value ?? ""
//							),
//							totalAncillaryFeesAndTaxes: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalAncillaryFeesAndTaxes|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalAncillaryFeesAndTaxes|Amount")[safe: index]?.value ?? ""
//							),
//							totalDutiesTaxesAndFees: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesTaxesAndFees|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalDutiesTaxesAndFees|Amount")[safe: index]?.value ?? ""
//							),
//							totalNetChargeWithDutiesAndTaxes: Money(
//								currency: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetChargeWithDutiesAndTaxes|Currency")[safe: index]?.value ?? "",
//								amount: stack.find("RateReply|RateReplyDetails|RatedShipmentDetails|ShipmentRateDetail|TotalNetChargeWithDutiesAndTaxes|Amount")[safe: index]?.value ?? ""
//							),
//							shipmentLegRateDetails: ShipmentLegRateDetail(
//								legDescription: <#T##String#>,
//								legOrigin: Address(
//									streetLines: <#T##String?#>,
//									city: <#T##String?#>,
//									stateOrProvinceCode: <#T##String?#>,
//									postalCode: <#T##String?#>,
//									urbanizationCode: <#T##String?#>,
//									countryCode: <#T##String?#>,
//									countryName: <#T##String?#>,
//									residential: <#T##Bool?#>
//								),
//								legOriginLocationId: <#T##String#>,
//								legDestination: Address(
//									streetLines: <#T##String?#>,
//									city: <#T##String?#>,
//									stateOrProvinceCode: <#T##String?#>,
//									postalCode: <#T##String?#>,
//									urbanizationCode: <#T##String?#>,
//									countryCode: <#T##String?#>,
//									countryName: <#T##String?#>,
//									residential: <#T##Bool?#>
//								),
//								legDestinationLocationId: <#T##String#>,
//								rateType: <#T##ReturnedRateType#>,
//								rateScale: <#T##String#>,
//								rateZone: <#T##String#>,
//								pricingCode: <#T##PricingCodeType#>,
//								ratedWeightMethod: <#T##RatedWeightMethod#>,
//								minimumChargeType: <#T##MinimumChargeType#>,
//								currencyExchangeRate: <#T##CurrencyExchangeRate#>,
//								specialRatingApplied: <#T##SpecialRatingAppliedType#>,
//								dimDivisor: <#T##UInt#>,
//								dimDivisorType: <#T##RateDimensionalDivisorType#>,
//								fuelSurchargePercent: <#T##NSDecimalNumber#>,
//								totalBillingWeight: Weight(
//									units: WeightUnits(rawValue: ),
//									value: <#T##NSDecimalNumber#>
//								),
//								totalDimWeight: Weight(
//									units: WeightUnits(rawValue: ),
//									value: <#T##NSDecimalNumber#>
//								),
//								totalBaseCharge: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalFreightDiscounts: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalNetFreight: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalSurcharges: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalNetFedExCharge: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalTaxes: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalNetCharge: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalRebates: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalDutiesAndTaxes: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalNetChargeWithDutiesAndTaxes: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								freightRateDetail: FreightRateDetail(
//									quoteNumber: <#T##String#>,
//									quoteType: FreightRateQuoteType(rawValue: ),
//									baseChargeCalculation: FreightBaseChargeCalculationType(rawValue: ),
//									baseCharges: FreightBaseCharge(
//										freightClass: <#T##FreightClassType#>,
//										ratedAsClass: <#T##FreightClassType#>,
//										nmfcCode: <#T##String#>,
//										description: <#T##String#>,
//										weight: Weight(
//											units: WeightUnits(rawValue: ),
//											value: <#T##NSDecimalNumber#>
//										),
//										chargeRate: Money(
//											currency: <#T##String#>,
//											amount: <#T##NSDecimalNumber#>
//										),
//										chargeBasis: <#T##FreightChargeBasisType#>,
//										extendedAmount: Money(
//											currency: <#T##String#>,
//											amount: <#T##NSDecimalNumber#>
//										)
//									),
//									notations: FreightRateNotation(
//										code: <#T##String#>,
//										description: <#T##String#>
//									)
//								),
//								freightDiscounts: <#T##RateDiscount#>,
//								rebates: <#T##Rebate#>, surcharges: <#T##Surcharge#>,
//								taxes: <#T##Tax#>, dutiesAndTaxes: <#T##EdtCommodityTax#>,
//								variableHandlingCharges: <#T##VariableHandlingCharges#>,
//								totalVariableHandlingCharges: <#T##VariableHandlingCharges#>
//							),
//							freightRateDetail: FreightRateDetail(
//								quoteNumber: <#T##String#>,
//								quoteType: <#T##FreightRateQuoteType#>,
//								baseChargeCalculation: <#T##FreightBaseChargeCalculationType#>,
//								baseCharges: <#T##FreightBaseCharge#>,
//								notations: <#T##FreightRateNotation#>
//							),
//							freightDiscounts: RateDiscount(
//								rateDiscountType: <#T##RateDiscountType#>,
//								description: <#T##String#>,
//								amount: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								percent: <#T##NSDecimalNumber#>
//							),
//							rebates: Rebate(
//								rebateType: <#T##RebateType#>,
//								description: <#T##String#>,
//								amount: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								percent: <#T##NSDecimalNumber#>
//							),
//							surcharges: Surcharge(
//								surchargeType: <#T##SurchargeType#>,
//								level: <#T##SurchargeLevelType#>,
//								description: <#T##String#>,
//								amount: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								)
//							),
//							taxes: Tax(
//								taxType: <#T##TaxType#>,
//								description: <#T##String#>,
//								amount: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								)
//							),
//							dutiesAndTaxes: <#T##EdtCommodityTax#>,
//							ancillaryFeesAndTaxes: <#T##AncillaryFeeAndTax#>,
//							variableHandlingCharges: <#T##VariableHandlingCharges#>,
//							totalVariableHandlingCharges: <#T##VariableHandlingCharges#>
//						),
//						ratedPackages: RatedPackageDetail(
//							trackingIds: <#T##TrackingId#>,
//							groupNumber: <#T##UInt#>,
//							effectiveNetDiscount: Money(
//								currency: <#T##String#>,
//								amount: <#T##NSDecimalNumber#>
//							),
//							adjustedCodCollectionAmount: Money(
//								currency: <#T##String#>,
//								amount: <#T##NSDecimalNumber#>
//							),
//							oversizeClass: <#T##OversizeClassType#>,
//							packageRateDetail: PackageRateDetail(
//								rateType: <#T##ReturnedRateType#>,
//								ratedWeightMethod: <#T##RatedWeightMethod#>,
//								minimumChargeType: <#T##MinimumChargeType#>,
//								billingWeight: Weight(
//									units: WeightUnits(rawValue: ),
//									value: <#T##NSDecimalNumber#>
//								),
//								dimWeight: Weight(
//									units: WeightUnits(rawValue: ),
//									value: <#T##NSDecimalNumber#>
//								),
//								oversizeWeight: Weight(
//									units: WeightUnits(rawValue: ),
//									value: <#T##NSDecimalNumber#>
//								),
//								baseCharge: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalFreightDiscounts: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								netFreight: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalSurcharges: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								netFedExCharge: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalTaxes: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								netCharge: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								totalRebates: Money(
//									currency: <#T##String#>,
//									amount: <#T##NSDecimalNumber#>
//								),
//								freightDiscounts: RateDiscount(
//									rateDiscountType: <#T##RateDiscountType#>,
//									description: <#T##String#>,
//									amount: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									),
//									percent: <#T##NSDecimalNumber#>
//								),
//								rebates: Rebate(
//									rebateType: <#T##RebateType#>,
//									description: <#T##String#>,
//									amount: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									),
//									percent: <#T##NSDecimalNumber#>
//								),
//								surcharges: Surcharge(
//									surchargeType: <#T##SurchargeType#>,
//									level: <#T##SurchargeLevelType#>,
//									description: <#T##String#>,
//									amount: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									)
//								),
//								taxes: Tax(
//									taxType: <#T##TaxType#>,
//									description: <#T##String#>,
//									amount: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									)
//								),
//								variableHandlingCharges: VariableHandlingCharges(
//									variableHandlingCharge: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									),
//									fixedVariableHandlingCharge: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									),
//									percentVariableHandlingCharge: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									),
//									totalCustomerCharge: Money(
//										currency: <#T##String#>,
//										amount: <#T##NSDecimalNumber#>
//									)
//								)
//							)
//						)
//					)*/
//			}
//		}
//	}
//}
