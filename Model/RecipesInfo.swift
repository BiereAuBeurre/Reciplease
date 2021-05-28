//
//  RecipesInfo.swift
//  Reciplease
//
//  Created by Manon Russo on 26/05/2021.
//

import Foundation

struct RecipesInfo: Decodable {
     let recipes: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case recipes = "hits"
    }
}

struct Recipe: Decodable {
    let name: String
    let recipeUrl: String
    let imageUrl: String?
    let ingredients: [String] // à convertir en string unique
    let totalTime: Double? // 0.0 pour nil chez certains à remplacer
    
    enum CodingKeys: String, CodingKey {
        case recipe
        case name = "label"
        case imageUrl = "image"
        case ingredients = "ingredientLines"
        case recipeUrl = "url"
        case totalTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recipe = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        name = try recipe.decode(String.self, forKey: .name)
        imageUrl = try recipe.decode(String.self, forKey: .imageUrl)
        ingredients = try recipe.decode([String].self, forKey: .ingredients)
        recipeUrl = try recipe.decode(String.self, forKey: .recipeUrl)
        let decodedTotalTime = try recipe.decode(Double.self, forKey: .totalTime)
        totalTime = decodedTotalTime == 0.0 ? nil : decodedTotalTime
//        ingredients = ingredients.joinded(separator:",")
    }
}

struct Ingredients: Decodable {
    let text: String
    let weight: Double
    let image: String?
}

//        if decodedTotalTime == 0.0 {
//            totalTime = nil
//        } else {
//            totalTime = decodedTotalTime
//        }
