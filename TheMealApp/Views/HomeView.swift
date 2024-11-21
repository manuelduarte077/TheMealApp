//
//  HomeView.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MealListView()
                .tabItem {
                    Label("Meals", systemImage: "list.dash")
                }
            CategoriesListView()
                .tabItem {
                    Label("Categories", systemImage: "fork.knife")
                }
        }
    }
}

#Preview {
    HomeView()
}
