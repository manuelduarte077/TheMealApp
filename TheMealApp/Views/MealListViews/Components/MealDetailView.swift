//
//  MealDetailView.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var mealDetailViewModel: MealDetailViewModel

    var body: some View {
        ScrollView {
            VStack {
                if mealDetailViewModel.isLoading {
                    ProgressView("Cargando detalles...")
                } else if let errorMessage = mealDetailViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else if let meal = mealDetailViewModel.mealDetail {
                    
                    VStack(alignment: .leading, spacing: 16) {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                        
                        Text(meal.strMeal)
                            .font(.title)
                            .padding(.bottom, 8)
                        
                        Text(meal.strInstructions ?? "No hay instrucciones disponibles.")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                } else {
                    Text("No se encontró información del detalle.")
                }
            }
            .padding()
        }
    }
}


