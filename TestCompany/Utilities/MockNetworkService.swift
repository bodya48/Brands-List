//
//  MockNetworkService.swift
//  TestCompany
//
//  Created by bod on 11/2/24.
//

import Foundation

enum MockNetworkServiceResult {
    case success
    case error(Error)
}

final class MockNetworkService: NetworkServiceProtocol {
    
    private let result: MockNetworkServiceResult
    
    init(result: MockNetworkServiceResult = .success) {
        self.result = result
    }
    
    func fetchManufacturers(page: Int) async throws -> PageDataModel {
        print(">>> making mock network request - fetchManufacturers")
        
        switch result {
        case .success:
            let brands = [
                "020":"Abarth",
                "032":"Aiways",
                "040":"Alfa Romeo",
                "042":"Alpina",
                "043":"Alpine",
                "057":"Aston Martin",
                "060":"Audi",
                "095":"Barkas",
                "107":"Bentley",
                "130":"BMW"]
            return PageDataModel(page: 0, pageSize: 10, totalPageCount: 10, wkda: brands)
            
        case .error(let error):
            throw error
        }
    }
    
    func fetchModels(manufacturerId: String, page: Int) async throws -> PageDataModel {
        switch result {
        case .success:
            let models = [
                "B-Max":"B-Max",
                "Bronco":"Bronco",
                "C-Max":"Alfa Romeo",
                "Capri":"Capri",
                "Cougar":"Cougar",
                "EcoSport":"EcoSport",
                "Econovan":"Econovan",
                "Edge":"Edge",
                "Escort":"Escort",
                "Explorer":"Explorer"]
            return PageDataModel(page: 0, pageSize: 10, totalPageCount: 2, wkda: models)
            
        case .error(let error):
            throw error
        }
    }
}
