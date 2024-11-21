//
//  MealDetailViewModel.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealResponse.Meal?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let mealService: MealService

    init(mealService: MealService = MealService()) {
        self.mealService = mealService
    }

    func loadMeal(meal: MealResponse.Meal) {
        Task {
            isLoading = true
            do {
                mealDetail = try await mealService.fetchMealDetails(mealID: meal.idMeal)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
