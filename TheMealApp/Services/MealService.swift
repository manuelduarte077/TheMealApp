//
//  MealService.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation

class MealService {
    
    private let networkService = NetworkService.shared
    
    func fetchMeals(category: String) async throws -> [MealResponse.Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)") else {
            throw NetworkError.invalidURL
        }
        
        let data = try await networkService.fetchData(from: url)
        
        do {
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            return mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func searchMeals(name: String) async throws -> [MealResponse.Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(name)") else {
            throw NetworkError.invalidURL
        }
        
        let data = try await networkService.fetchData(from: url)
        
        do {
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            return mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func fetchMealDetails(mealID: String) async throws -> MealResponse.Meal {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            throw NetworkError.invalidURL
        }
        
        let data = try await networkService.fetchData(from: url)
        
        do {
            let mealDetailResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            guard let mealDetail = mealDetailResponse.meals.first else {
                throw NetworkError.noData
            }
            return mealDetail
        } catch {
            throw NetworkError.decodingError
        }
    }
}
