//
//  RemoteImageView.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct RemoteImageView: View {
    let url: URL?
    var size: CGFloat = 150
    var cornerRadius: CGFloat = 12
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundColor(.gray)
                    .opacity(0.6)
                
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(radius: 4)
    }
}
