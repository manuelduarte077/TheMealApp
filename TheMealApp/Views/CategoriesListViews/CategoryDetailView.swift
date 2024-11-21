//
//  CategoryDetailView.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct CategoryDetailView: View {
    
    let category: CategoryResponse.Category
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                RemoteImageView(url: URL(string: category.strCategoryThumb), size: 200, cornerRadius: 16)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                    .padding()
                
                Text(category.strCategory)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text(category.strCategoryDescription)
                    .font(.body)
                    .lineSpacing(10)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
        }
    }
}

#Preview {
    // Vista de ejemplo para `CategoryDetailView`
    CategoryDetailView(category: CategoryResponse.Category(idCategory: "1", strCategory: "Beef", strCategoryThumb: "https://www.themealdb.com/images/category/beef.png", strCategoryDescription: "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times. Beef is a source of high-quality protein and essential nutrients."))
}
