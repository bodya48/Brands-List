//
//  ActivityIndicatorView.swift
//  TestCompany
//
//  Created by bod on 10/30/24.
//

import SwiftUI

struct ActivityIndicatorView: View {
    
    var tintColor: Color = .primary
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

#Preview {
    ActivityIndicatorView()
        .frame(width: 40, height: 40)
}
