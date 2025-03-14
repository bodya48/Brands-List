//
//  NetworkHelper.swift
//  TestCompany
//
//  Created by bod on 10/29/24.
//

import Foundation

struct API {
    static let baseURL = URL(string: "http://server-address-to-added.com")! // server address to added

    static let pageSizeName: String = "pageSize"
    static let pageSizeValue: Int = 15
    
    static let keyName: String = "wa_key"
    static let keyValue: String = "key_walue" // access key value should be added
    
    enum Endpoint {
        case manufacturer(page: Int)
        case model(manufacturer: String, page: Int)
        
        var path: String {
            switch self {
            case .manufacturer:
                return "/v1/car-types/manufacturer"
            case .model:
                return "/v1/car-types/main-types"
            }
        }
        
        var queryItems: [URLQueryItem]? {
            switch self {
            case .manufacturer(let page):
                return [
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: pageSizeName, value: "\(pageSizeValue)"),
                    URLQueryItem(name: keyName, value: "\(keyValue)")
                ]
            case .model(let manufacturer, let page):
                return [
                    URLQueryItem(name: "manufacturer", value: manufacturer),
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: pageSizeName, value: "\(pageSizeValue)"),
                    URLQueryItem(name: keyName, value: keyValue)
                ]
            }
        }
        
        func url() -> URL? {
            var urlComponents = URLComponents(url: API.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
            urlComponents?.queryItems = queryItems
            return urlComponents?.url
        }
    }
}
