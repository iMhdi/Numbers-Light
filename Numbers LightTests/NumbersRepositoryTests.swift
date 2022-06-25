//
//  NumbersRepositoryTests.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import XCTest
@testable import Numbers_Light

class NumbersRepositoryTests: XCTestCase {
    
    var numbersRepository: NumbersRepository?

    override func setUpWithError() throws {
        numbersRepository = NumbersRepository()
    }

    override func tearDownWithError() throws {
        numbersRepository = nil
    }
    
    func testNumbersListSuccess() throws {
        let expectation = expectation(description: "Calling API")
        
        var apiResponse: Numbers? = nil
        numbersRepository?.fetchNumbersList(withCompletion: { numbers in
            apiResponse = numbers
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(
                apiResponse != nil,
                "expectation failed : \(error?.localizedDescription ?? "")"
            )
        }
    }
    
    func testNumberDetailsSuccess() throws {
        let expectation = expectation(description: "Calling API")
        
        var apiResponse: NumberBO? = nil
        numbersRepository?.fetchNumber(withName: "1", andCompletion: { number in
            apiResponse = number
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(
                apiResponse != nil,
                "expectation failed : \(error?.localizedDescription ?? "")"
            )
        }
    }
    
    func testMockedNumbers() {
        
    }
}
