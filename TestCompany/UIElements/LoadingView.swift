//
//  ListLoadingView.swift
//  TestCompany
//
//  Created by bod on 11/3/24.
//

import SwiftUI

struct LoadingView: View {
    
    private let itemsNumber: Int
    private var items: [String] { Array(repeating: "item", count: itemsNumber) }
    
    init(itemsNumber: Int = 15) {
        self.itemsNumber = itemsNumber
    }
    
    var body: some View {
        List {
            ForEach(items.indices, id: \.self) { index in
                ListItemView(name: "sometemplatemanufacturer")
                    .listRowBackground(index % 2 == 0 ? Constants.colorEven : Constants.colorOdd)
            }
            .listRowSeparator(.hidden)
            .shimmer(when: .constant(true))
        }
    }
}

#Preview {
    LoadingView(itemsNumber: 10)
}
