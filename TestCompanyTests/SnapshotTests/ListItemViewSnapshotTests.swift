//
//  ListItemViewSnapshotTests.swift
//  TestCompanyTests
//
//  Created by bod on 11/3/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import TestCompany

final class ListItemViewSnapshotTests: XCTestCase {
    
    private let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
    private let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    
    func testListItemView_LightMode() {
        let view = ListItemView(name: MockDataProvider.manufacturer.brand)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitLightMode))
    }
    
    func testListItemView_DarkMode() {
        let view = ListItemView(name: MockDataProvider.manufacturer.brand)
        assertSnapshot(of: view.toVC(), as: .image(on: .iPhoneX, traits: traitDarkMode))
    }
}
