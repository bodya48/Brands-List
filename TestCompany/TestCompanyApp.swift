//
//  TestCompanyApp.swift
//  TestCompany
//
//  Created by bod on 10/29/24.
//

import SwiftUI

@main
struct TestCompanyApp: App {
    
    private var networkService: NetworkServiceProtocol {
        if isRunningUnitTests() {
            return MockNetworkService()
        } else {
            return NetworkService()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = MainViewModel(networkService: networkService)
            MainView(viewModel: viewModel)
        }
    }
    
    func isRunningUnitTests() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("unitTestsMode")
        /*
         if NSClassFromString("XCTestCase") ==  nil {
         }
         */

    }
}
