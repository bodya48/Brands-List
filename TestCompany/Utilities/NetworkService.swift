//
//  NetworkManager.swift
//  TestCompany
//
//  Created by bod on 10/29/24.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func fetchManufacturers(page: Int) async throws -> PageDataModel
    func fetchModels(manufacturerId: String, page: Int) async throws -> PageDataModel
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchManufacturers(page: Int) async throws -> PageDataModel {
        print(">>> making real network request - fetchManufacturers")
        guard let url = API.Endpoint.manufacturer(page: page).url() else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try JSONDecoder().decode(PageDataModel.self, from: data)
        } catch {
            throw error
        }
    }
    
    func fetchModels(manufacturerId: String, page: Int) async throws -> PageDataModel {
        guard let url = API.Endpoint.model(manufacturer: manufacturerId, page: page).url() else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try JSONDecoder().decode(PageDataModel.self, from: data)
        } catch {
            throw error
        }
    }
    
}
