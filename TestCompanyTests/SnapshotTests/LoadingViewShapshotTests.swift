//
//  LoadingViewShapshotTests.swift
//  TestCompanyTests
//
//  Created by bod on 11/3/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import TestCompany

final class LoadingViewShapshotTests: XCTestCase {

    private let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
    private let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    
    func testLoadingView_DefaultItemsNumber_LightMode() {
        let view = LoadingView()
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitLightMode))
    }
    
    func testLoadingView_DefaultItemsNumber_DarkMode() {
        let view = LoadingView()
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
    
    func testLoadingView_ThreeItemsNumber_LightMode() {
        let view = LoadingView(itemsNumber: 3)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitLightMode))
    }
    
    func testLoadingView_ThreeItemsNumber_DarkMode() {
        let view = LoadingView(itemsNumber: 3)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
}
