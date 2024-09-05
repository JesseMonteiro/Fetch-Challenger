//
//  ApiManeger.swift
//  Fetch Challenger
//
//  Created by Jesse Monteiro Ferreira on 05/09/24.
//

import Foundation

class MealAPI {
    static let shared = MealAPI()
    
    func fetchDesserts() async throws -> [Meal] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(MealResponse.self, from: data)
        return decodedData.meals.sorted(by: { $0.strMeal < $1.strMeal })
    }
    
    func fetchMealDetails(id: String) async throws -> MealDetail {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return decodedData.meals.first!
    }
}

struct MealResponse: Decodable {
    let meals: [Meal]
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
