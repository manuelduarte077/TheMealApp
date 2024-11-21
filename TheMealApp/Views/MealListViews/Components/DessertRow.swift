//
//  DessertRow.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct DessertRow: View {
    let meal: MealResponse.Meal
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .cornerRadius(8)
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .background(Color.gray)
                        .cornerRadius(8)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 75, height: 75)
            
            Text(meal.strMeal)
                .font(.headline)
        }
    }
}
