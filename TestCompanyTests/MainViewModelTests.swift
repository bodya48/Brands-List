//
//  MainViewModelTests.swift
//  TestCompanyTests
//
//  Created by bod on 11/2/24.
//

import XCTest
import Combine
@testable import TestCompany

@MainActor
final class MainViewModelTests: XCTestCase {
    
    private var cancellables = [AnyCancellable]()
    
    func testViewStateIsEmpty_whenInitialised() {
        let expectation = XCTestExpectation(description: "viewState changes")
        var receivedValues: [MainViewState] = []
        
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        
        viewModel.$viewState.sink { state in
            receivedValues.append(state)
            expectation.fulfill()
        }
        .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(receivedValues, [.emptyList])
    }
    
    func testViewStateIsContent_whenLoadContent() async {
        let expectation = XCTestExpectation(description: "viewState changes")
        let manufacturersArray: [Manufacturer] = [
            Manufacturer(brand: "Abarth", brandId: "020"),
            Manufacturer(brand: "Aiways", brandId: "032"),
            Manufacturer(brand: "Alfa Romeo", brandId: "040"),
            Manufacturer(brand: "Alpina", brandId: "042"),
            Manufacturer(brand: "Alpine", brandId: "043"),
            Manufacturer(brand: "Aston Martin", brandId: "057"),
            Manufacturer(brand: "Audi", brandId: "060"),
            Manufacturer(brand: "BMW", brandId: "130"),
            Manufacturer(brand: "Barkas", brandId: "095"),
            Manufacturer(brand: "Bentley", brandId: "107")
        ]
        let expectedValues: [MainViewState] = [
            .emptyList,
            .content(manufacturersArray)
        ]
        var receivedValues: [MainViewState] = []
        
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        
        viewModel.$viewState.sink { state in
            receivedValues.append(state)
            
            if receivedValues.count == 2 {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        await viewModel.loadContent()
        
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(receivedValues, expectedValues)
    }
    
    func testViewStateIsError_whenBadUrlIsThrown() async {
        let expectation = XCTestExpectation(description: "viewState changes")
        let errorType = URLError(.badURL)
        let expectedValues: [MainViewState] = [
            .emptyList,
            .error(errorType.localizedDescription)
        ]
        var receivedValues: [MainViewState] = []
        
        let mockService = MockNetworkService(result: .error(errorType))
        let viewModel = MainViewModel(networkService: mockService)
        
        viewModel.$viewState.sink { state in
            receivedValues.append(state)
            
            if receivedValues.count == 2 {
                expectation.fulfill()
            }
        }
        .store(in: &cancellables)
        
        await viewModel.loadContent()
        
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(receivedValues, expectedValues)
    }
    
    func testAlertIsTrue_whenSelectedManufacturerAndModelAssigned() {
        let expectation = XCTestExpectation(description: "alert changes")
        var receivedValues: [Bool] = []
        
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        
        viewModel.$showAlert.sink(receiveValue: { value in
            receivedValues.append(value)
            expectation.fulfill()
        })
        .store(in: &cancellables)
        
        viewModel.selected(
            manufacturer: Manufacturer(brand: "Ford", brandId: "055"),
            model: ModelType(modelType: "Edge", modelTypeId: "Edge"))
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(receivedValues, [false, true])
    }
    
    func testAlertMessageIsCorrect_whenSelectedManufacturerAndModelAssigned() {
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        
        viewModel.selected(
            manufacturer: Manufacturer(brand: "Ford", brandId: "055"),
            model: ModelType(modelType: "Edge", modelTypeId: "Edge"))
        
        XCTAssertEqual(viewModel.alertMessage, "Car selected:\nFord Edge")
    }
    
    func testShouldDisplayActivityRowIsTrue_whenLastManufacturerIsShown() async {
        let manufacturer = Manufacturer(brand: "BMW", brandId: "130")
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        
        await viewModel.loadContent()
        
        XCTAssertEqual(viewModel.shouldDisplayActivityRow(for: manufacturer), true)
    }
    
    func testShouldDisplayActivityRowIsFalse_whenNotLastManufacturerIsShown() async {
        let manufacturer = Manufacturer(brand: "Audi", brandId: "060")
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        
        await viewModel.loadContent()
        
        XCTAssertEqual(viewModel.shouldDisplayActivityRow(for: manufacturer), false)
    }
}
