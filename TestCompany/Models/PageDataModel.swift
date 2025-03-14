//
//  ManufacturerDataModel.swift
//  TestCompany
//
//  Created by bod on 10/29/24.
//

import Foundation

struct PageDataModel: Codable {
    let page, pageSize, totalPageCount: Int
    let wkda: [String: String]
}
