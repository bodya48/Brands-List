//
//  ApiHelperTests.swift
//  TestCompanyTests
//
//  Created by bod on 11/2/24.
//

import XCTest
@testable import TestCompany

final class ApiHelperTests: XCTestCase {

    func testUrlForManufacturerIsCorrect() throws {
        let testUrlString = "http://api-test-url-string-test.com/v1/key"
        let page: Int = 1
        
        let url = API.Endpoint.manufacturer(page: page).url()
        
        guard let url = url else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(url.absoluteString, testUrlString)
    }
    
    func testUrlForModelTypesIsCorrect() throws {
        let testUrlString = "http://api-test-url-string-test.com/v1/key"
        let manufacturerId: String = "255"
        let page: Int = 2
        
        let url = API.Endpoint.model(manufacturer: manufacturerId, page: page).url()
        
        guard let url = url else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(url.absoluteString, testUrlString)
    }
}
