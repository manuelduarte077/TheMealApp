//
//  NetworkService.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case badResponse
}

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    // Fetch all categories
    // https://www.themealdb.com/api/json/v1/1/categories.php
    func fetchAllCategories() {}
    
    // Filter by Category
    // https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
    func fetchCategories() {}
    
    // Search by name
    // https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata
//    func searchMeals() {}
    func searchMeals(name: String) async throws -> [MealResponse.Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(name)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.badResponse
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            do {
                let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                return mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
            } catch {
                throw NetworkError.decodingError
            }
        } catch {
            throw error
        }
    }
    
    // Fetch all meals
    // https://themealdb.com/api/json/v1/1/filter.php?c=\(category)
    func fetchMeals(category: String) async throws -> [MealResponse.Meal] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Check for valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.badResponse
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            do {
                let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                // Sort meals alphabetically by name
                return mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
            } catch {
                throw NetworkError.decodingError
            }
        } catch {
            // Throw any remaining errors if checks fail
            throw error
        }
    }
    
    // Fetch meal details
    // https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)
    func fetchMealDetails(mealID: String) async throws -> MealResponse.Meal {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.badResponse
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            do {
                let mealDetailResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                
                guard let mealDetail = mealDetailResponse.meals.first else {
                    throw NetworkError.noData
                }
                
                return mealDetail
            } catch {
                throw NetworkError.decodingError
            }
        } catch {
            throw error
        }
    }
    
}
