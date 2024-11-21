//
//  RectangleDividerView.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct RectangleDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.white.opacity(0.5))
            .padding()
        
    }
}

#Preview {
    RectangleDividerView()
}
