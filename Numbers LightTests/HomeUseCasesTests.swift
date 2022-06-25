//
//  HomeUseCasesTests.swift
//  Test-TechniqueTests
//
//  Created by El Mahdi Boukhris on 24/05/2022.
//

import XCTest
@testable import Numbers_Light

class HomeUseCasesTests: XCTestCase {
    
    var homeUseCases: HomeUseCases?
    var numbersRepository: NumbersRepositoryMock?

    override func setUpWithError() throws {
        numbersRepository = NumbersRepositoryMock()
        homeUseCases = HomeUseCases(numbersRepository: numbersRepository)
    }

    override func tearDownWithError() throws {
        numbersRepository = nil
        homeUseCases = nil
    }
    
    func testNumbersListSuccess() throws {
        let numbersList = [NumberBO(name: "100", text: "cent", image: "https://url.com")]
        numbersRepository?.allNumbers = numbersList
        homeUseCases?.executeGetNumbersList(withCompletion: { numbers in
            XCTAssertNotNil(numbers)
            XCTAssertTrue(numbers!.count == 1, "Expected 1 item | Received \(numbers!.count) elements")
        })
    }
    
    func testNumbersListEmpty() throws {
        let numbersList = Numbers()
        numbersRepository?.allNumbers = numbersList
        homeUseCases?.executeGetNumbersList(withCompletion: { numbers in
            XCTAssertNotNil(numbers)
            XCTAssertTrue(numbers!.count == 0, "Expected empty list | Received \(numbers!.count) elements")
        })
    }
    
    func testNumbersListNil() throws {
        numbersRepository?.allNumbers = nil
        homeUseCases?.executeGetNumbersList(withCompletion: { numbers in
            XCTAssertNil(numbers, "Expected nil list | Received \(numbers?.count ?? 0) elements")
        })
    }
    
    func testShouldRefreshListFullList() {
        let fullList = [NumberBO(name: "100", text: "cent", image: "https://url.com")]
        let shouldForceRefresh = homeUseCases?.executeShouldForceRefresh(ofList: fullList)
        
        XCTAssertNotNil(shouldForceRefresh)
        XCTAssertFalse(shouldForceRefresh!, "Expected false for a list with \(fullList.count) items | Found \(shouldForceRefresh!)")
    }
    
    func testShouldRefreshListEmptyList() {
        let emptyList = Numbers()
        let shouldForceRefresh = homeUseCases?.executeShouldForceRefresh(ofList: emptyList)
        
        XCTAssertNotNil(shouldForceRefresh)
        XCTAssertTrue(shouldForceRefresh!, "Expected true for a list with \(emptyList.count) items | Found \(shouldForceRefresh!)")
    }
    
    func testShouldRefreshListNilList() {
        let nilList: Numbers? = nil
        let shouldForceRefresh = homeUseCases?.executeShouldForceRefresh(ofList: nilList)
        
        XCTAssertNotNil(shouldForceRefresh)
        XCTAssertTrue(shouldForceRefresh!, "Expected true for a nil list | Found \(shouldForceRefresh!)")
    }
}
