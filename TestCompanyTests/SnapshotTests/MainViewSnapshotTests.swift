//
//  MainViewSnapshotTests.swift
//  TestCompanyTests
//
//  Created by bod on 11/3/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import TestCompany

@MainActor
final class MainViewSnapshotTests: XCTestCase {
    
    private let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
    private let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    
    func testMainView_whenViewStateIsEmpty_LightMode() {
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        let view = MainView(viewModel: viewModel)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitLightMode))
    }
    
    func testMainView_whenViewStateIsEmpty_DarkMode() {
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        let view = MainView(viewModel: viewModel)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
    
    func testMainView_whenViewStateIsContent_LightMode() async {
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        let view = MainView(viewModel: viewModel)
        await viewModel.loadContent()
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitLightMode))
    }
    
    func testMainView_whenViewStateIsContent_DarkMode() async {
        let mockService = MockNetworkService()
        let viewModel = MainViewModel(networkService: mockService)
        let view = MainView(viewModel: viewModel)
        await viewModel.loadContent()
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
    
    func testMainView_whenViewStateIsError_LightMode() async {
        let errorType = URLError(.badURL)
        let mockService = MockNetworkService(result: .error(errorType))
        let viewModel = MainViewModel(networkService: mockService)
        let view = MainView(viewModel: viewModel)
        await viewModel.loadContent()
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitLightMode))
    }
    
    func testMainView_whenViewStateIsError_DarkMode() async {
        let errorType = URLError(.badURL)
        let mockService = MockNetworkService(result: .error(errorType))
        let viewModel = MainViewModel(networkService: mockService)
        let view = MainView(viewModel: viewModel)
        await viewModel.loadContent()
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
}
