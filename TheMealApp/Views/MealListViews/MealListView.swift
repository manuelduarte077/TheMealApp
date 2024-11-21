//
//  MealListView.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var categoriesViewModel = CategoriesViewModel()
    @StateObject private var mealListViewModel = MealListViewModel()
    @State private var selectedCategory: CategoryResponse.Category?
    
    @StateObject private var mealDetailViewModel = MealDetailViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if categoriesViewModel.isLoading {
                    ProgressView("Cargando categorías...")
                        .padding()
                } else if let errorMessage = categoriesViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    categoryListView
                }
            }
            .onAppear {
                Task {
                    await categoriesViewModel.fetchCategories()
                }
            }
            .navigationTitle("Meals")
        }
    }
    
    // Subvista para la lista de categorías
    @ViewBuilder
    private var categoryListView: some View {
        List {
            ForEach(categoriesViewModel.categories, id: \.idCategory) { category in
                Section(header: Text(category.strCategory).font(.headline)) {
                    sectionContent(for: category)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    // Subvista para el contenido de una sección
    @ViewBuilder
    private func sectionContent(for category: CategoryResponse.Category) -> some View {
        if selectedCategory == category {
            if mealListViewModel.isLoading {
                ProgressView("Cargando comidas...")
            } else if let errorMessage = mealListViewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                ForEach(mealListViewModel.mealsList, id: \.idMeal) { meal in
                    mealRow(for: meal)
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Text(category.strCategoryDescription)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .onTapGesture {
                selectedCategory = category
                loadMeals(for: category)
            }
        }
    }
    
    // Subvista para una fila de comida
    @ViewBuilder
    private func mealRow(for meal: MealResponse.Meal) -> some View {
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(meal.strMeal)
                    .font(.body)
                
                Button(action: {
                    mealDetailViewModel.loadMeal(meal: meal)
                    mealListViewModel.showingDetail = true
                }) {
                    Text("Ver detalles")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $mealListViewModel.showingDetail) {
                    MealDetailView(mealDetailViewModel: mealDetailViewModel)
                }
            }
            .padding()
        }
    }
    
    // Método para cargar comidas por categoría
    private func loadMeals(for category: CategoryResponse.Category) {
        Task {
            await mealListViewModel.loadMeals(category: category.strCategory)
        }
    }
}

#Preview {
    MealListView()
}
