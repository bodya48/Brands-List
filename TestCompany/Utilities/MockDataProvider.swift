//
//  MockDataProvider.swift
//  TestCompany
//
//  Created by bod on 10/30/24.
//

import Foundation

enum MockDataProvider {
    
    static let manufacturer = Manufacturer(brand: "Audi", brandId: "060")
    static let modelType = ModelType(modelType: "A8", modelTypeId: "A8")
    
    static let errorBadURL = "The operation couldn't be completed.\nNSURLErrorDomain error -1011."
}
