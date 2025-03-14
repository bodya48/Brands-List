//
//  LastRowShimmerView.swift
//  TestCompany
//
//  Created by bod on 11/3/24.
//

import SwiftUI

struct LastRowShimmerView: View {
    var body: some View {
        HStack {
            Text("Somemanufacturertemplatename")
                .font(.headline)
            Spacer()
        }
        .shimmer(when: .constant(true))
    }
}

#Preview {
    LastRowShimmerView()
        .frame(width: 300, height: 30)
}
