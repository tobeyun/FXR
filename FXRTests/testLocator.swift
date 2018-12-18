//
//  testLocator.swift
//  FXRTests
//
//  Created by Tobey Unruh on 12/16/18.
//  Copyright © 2018 Tobey Unruh. All rights reserved.
//

import XCTest

@testable import FXR

class testLocator: XCTestCase {

	var testLocator: SearchLocationsRequest!
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		testLocator = SearchLocationsRequest(
			webAuthenticationDetail: WebAuthenticationDetail(
				parentCredential: nil,
				userCredential: WebAuthenticationCredential(
					key: KeychainManager.queryData(itemKey: "key") as? String ?? "",
					password: KeychainManager.queryData(itemKey: "password") as? String ?? "")
			),
			clientDetail: ClientDetail(
				accountNumber: KeychainManager.queryData(itemKey: "account") as? String ?? "",
				meterNumber: KeychainManager.queryData(itemKey: "meter") as? String ?? "",
				integratorId: nil,
				region: nil,
				localization: nil),
			transactionDetail: TransactionDetail(customerTransactionId: "FXR LOCATOR \(Date())", localization: nil),
			effectiveDate: "2018-12-17",
			locationsSearchCriterion: LocationsSearchCriteriaType.ADDRESS,
			shipperAccountNumber: nil,
			uniqueTrackingNumber: nil,
			address: Address(
				streetLines: nil,
				city: nil,
				stateOrProvinceCode: nil,
				postalCode: "46131",
				urbanizationCode: nil,
				countryCode: "US",
				countryName: nil,
				residential: nil),
			phoneNumber: nil,
			geographicalCoordinates: nil,
			multipleMatchesAction: MultipleMatchesActionType.RETURN_ALL,
			sortDetail: nil,
			constraints: SearchLocationConstraints(
				radiusDistance: Distance(value: 25.0, units: DistanceUnits.MI),
				dropOffTimeNeeded: nil,
				resultsFilters: nil,
				supportedRedirectsToHoldServices: nil,
				requiredLocationAttributes: nil,
				requiredLocationCapabilities: nil,
				shipmentDetail: nil,
				resultsToSkip: nil,
				resultsRequested: nil,
				locationContentOptions: nil,
				locationTypesToInclude: nil)
		)
		
		print("\(testLocator!)")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		testLocator = nil
    }

	func testServiceLocator()
	{
		// Create an expectation for a background download task.
		let expectation = XCTestExpectation(description: "Test Service Locator Web Service Call")
	
		// Create a URL for a web page to be downloaded.
		let url = URL(string: UserDefaults.standard.string(forKey: "ws-url")!)!
		
		let dataTask = URLSession.shared.dataTask(with: getUrlRequest(body: "\(testLocator!)", url2: "\(url)")) { (data2, _, _) in
			
			// Make sure we downloaded some data.
			XCTAssertNotNil(data2, "No data was downloaded.")
			
			print(NSString(data: data2!, encoding: String.Encoding.utf8.rawValue) ?? "")
			
			// Fulfill the expectation to indicate that the background task has finished successfully.
			expectation.fulfill()
		}
		
		// Start the download task.
		dataTask.resume()
		
		// Wait until the expectation is fulfilled, with a timeout of 10 seconds.
		wait(for: [expectation], timeout: 20.0)
	}
	
	func getUrlRequest(body: String, url2: String) -> URLRequest
	{
		var request = URLRequest(url: URL(string: url2)!)
		
		request.httpMethod = "POST"
		request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
		request.httpBody = body.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
		
		return request
	}

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
