//
//  ContentView.swift
//  Fetch Challenger
//
//  Created by Jesse Monteiro Ferreira on 05/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var meals: [Meal] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Loading meals...")
            } else {
                List(meals) { meal in
                    NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                        HStack {
                            if let imageUrl = meal.strMealThumb, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image.resizable().aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                            }
                            Text(meal.strMeal)
                        }
                    }
                }
                .navigationTitle("Desserts")
            }
        }
        .task {
            do {
                meals = try await MealAPI.shared.fetchDesserts()
                isLoading = false
            } catch {
                print("Failed to load meals: \(error)")
            }
        }
    }
}
#Preview {
    ContentView()
}
