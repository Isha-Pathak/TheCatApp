//
//  CatListWebServiceTests.swift
//  TheCatAppTests
//
//  Created by isha pathak on 30/06/22.
//

import XCTest

class CatListWebServiceTests: XCTestCase {

    let mockListWebService = MockListWebService()

    func testListWebServiceResponse() {
        let expectation = self.expectation(description: "Cat List from Web Service Expected")
        mockListWebService.fetchListFromServer(){ json, error in

            XCTAssertNil(error)
            guard json != nil else {
                XCTFail()
                return
            }
            do {
                XCTAssertNotNil(json)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
