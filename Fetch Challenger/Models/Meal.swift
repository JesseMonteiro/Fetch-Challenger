//
//  Meal.swift
//  Fetch Challenger
//
//  Created by Jesse Monteiro Ferreira on 05/09/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String?
    
    var id: String {
        return idMeal
    }
}
