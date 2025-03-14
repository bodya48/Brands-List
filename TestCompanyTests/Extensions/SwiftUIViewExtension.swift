//
//  SwiftUIExtension.swift
//  TestCompanyTests
//
//  Created by bod on 11/3/24.
//

import SwiftUI

extension SwiftUI.View {
    
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
