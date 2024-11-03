//
//  CategoryService.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation

class CategoryService {
    
    private let networkService = NetworkService.shared
    
    func fetchCategories() async throws -> [CategoryResponse.Category] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            throw NetworkError.invalidURL
        }
        
        let data = try await networkService.fetchData(from: url)
        
        do {
            let categoryResponse = try JSONDecoder().decode(CategoryResponse.self, from: data)
            return categoryResponse.categories.sorted { $0.strCategory < $1.strCategory }
        } catch {
            throw NetworkError.decodingError
        }
    }
}
