//
//  CategoriesViewModel.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation


@MainActor
class CategoriesViewModel: ObservableObject {
    @Published var categories: [CategoryResponse.Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: CategoryService
    
    // Inyectar `CategoryService` para permitir fácil personalización y pruebas
    init(service: CategoryService = CategoryService()) {
        self.service = service
    }
    
    // List all categories
    func fetchCategories() async {
        isLoading = true
        errorMessage = nil // Limpiar mensajes de error previos
        
        do {
            categories = try await service.fetchCategories()
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching categories: \(error)")
        }
        
        isLoading = false
    }
    
}
