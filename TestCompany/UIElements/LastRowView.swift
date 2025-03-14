//
//  LastRowView.swift
//  TestCompany
//
//  Created by bod on 10/30/24.
//

import SwiftUI

struct LastRowListView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                ActivityIndicatorView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
    }
}

#Preview {
    LastRowListView()
        .frame(width: 300, height: 50)
}
