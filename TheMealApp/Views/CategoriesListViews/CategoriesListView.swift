//
//  CategoriesListViews.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct CategoriesListView: View {
    @StateObject private var categoriesListVM = CategoriesViewModel()
    @State private var selectedCategory: CategoryResponse.Category?
    @State private var isShowingDetailCategory = false
    
    var body: some View {
        NavigationView {
            VStack {
                if categoriesListVM.isLoading {
                    ProgressView("Loading Categories...")
                        .padding()
                } else if let errorMessage = categoriesListVM.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(categoriesListVM.categories) { category in
                        VStack(alignment: .leading) {
                            HStack {
                                //  Category Image
                                RemoteImageView(url: URL(string: category.strCategoryThumb), size: 150, cornerRadius: 12)
                                    .padding(.bottom, 10)
                                    .padding(.horizontal, 10)
                                
                                
                                // Category Name
                                Text(category.strCategory)
                                    .font(.headline)
                                    .padding(.bottom, 5)
                            }
                            
                            // Category Description
                            Text(category.strCategoryDescription)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                        .onTapGesture {
                            selectedCategory = category
                            isShowingDetailCategory.toggle()
                        }
                    }
                    
                }
            }
            .onAppear {
                Task {
                    await categoriesListVM.fetchCategories()
                }
            }
            .sheet(isPresented: $isShowingDetailCategory) {
                if let selectedCategory  = selectedCategory {
                    CategoryDetailView(category: selectedCategory)
                }
            }
            .navigationTitle("Meal Categories")
        }
    }
}

#Preview {
    CategoriesListView()
}
