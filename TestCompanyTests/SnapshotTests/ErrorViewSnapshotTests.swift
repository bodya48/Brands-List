//
//  ErrorViewSnapshotTests.swift
//  TestCompanyTests
//
//  Created by bod on 11/3/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import TestCompany

final class ErrorViewSnapshotTests: XCTestCase {
    
    private let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
    private let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    
    func testErrorView_LightMode() {
        let view = ErrorView(description: MockDataProvider.errorBadURL)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitLightMode))
    }
    
    func testErrorView_DarkMode() {
        let view = ErrorView(description: MockDataProvider.errorBadURL)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
}
