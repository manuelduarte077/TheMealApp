//
//  MealListViewModel.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation


@MainActor
class MealListViewModel: ObservableObject {
    @Published var mealsList: [MealResponse.Meal] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingDetail = false
    
    
    private let mealService: MealService

    init(mealService: MealService = MealService()) {
        self.mealService = mealService
    }

    func loadMeals(category: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let meals = try await mealService.fetchMeals(category: category)
            mealsList.append(contentsOf: meals)
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching meals for category \(category): \(error)")
        }

        isLoading = false
    }
}
