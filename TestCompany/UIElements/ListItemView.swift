//
//  ListItemView.swift
//  TestCompany
//
//  Created by bod on 10/29/24.
//

import SwiftUI

struct ListItemView: View {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    ListItemView(name: MockDataProvider.manufacturer.brand)
        .frame(width: 300, height: 30)
}
