//
//  DataModels.swift
//  Fetch Challenger
//
//  Created by Jesse Monteiro Ferreira on 05/09/24.
//

import Foundation

struct MealDetail: Decodable {
    var strMeal: String
    var strInstructions: String
    var ingredients: [String]
    var strYoutube: String?  // Add this line to include the YouTube link

    // Custom decoding for ingredients and measurements
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)  // Add this line for YouTube link

        var tempIngredients = [String]()

        // Loop through ingredients and measurements
        for i in 1...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")!

            let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey) ?? ""
            let measure = try container.decodeIfPresent(String.self, forKey: measureKey) ?? ""

            if !ingredient.isEmpty, !measure.isEmpty {
                tempIngredients.append("\(measure) \(ingredient)")
            }
        }

        ingredients = tempIngredients
    }

    // Define CodingKeys
    private enum CodingKeys: String, CodingKey {
        case strMeal, strInstructions, strYoutube  // Add strYoutube to the coding keys
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
}
