//
//  RecipesInfo.swift
//  Reciplease
//
//  Created by Manon Russo on 26/05/2021.
//

import Foundation

struct RecipesInfo: Decodable {
     let recipes: [Recipe]
     let count: Int
    
    enum CodingKeys: String, CodingKey {
        case recipes = "hits"
        case count
    }
}

struct Recipe: Decodable {
    let name: String
    let recipeUrl: String
    let imageUrl: String?
    let totalTime: Double
    let yield: Double
    let ingredients: [String]
            
    enum CodingKeys: String, CodingKey {
        case recipe
        case name = "label"
        case imageUrl = "image"
        case recipeUrl = "url"
        case totalTime
        case yield
        case ingredients = "ingredientLines"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recipe = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        name = try recipe.decode(String.self, forKey: .name)
        imageUrl = try recipe.decode(String.self, forKey: .imageUrl)
        ingredients = try recipe.decode([String].self, forKey: .ingredients)
        recipeUrl = try recipe.decode(String.self, forKey: .recipeUrl)
        totalTime = try recipe.decode(Double.self, forKey: .totalTime)
        yield = try recipe.decode(Double.self, forKey: .yield)
    }
}

extension Recipe {
    init(from recipeEntity: RecipeEntity) {
        self.name = recipeEntity.name ?? ""
        self.recipeUrl = recipeEntity.recipeUrl ?? ""
        self.imageUrl = recipeEntity.imageUrl ?? ""
        if let ingredientsData = recipeEntity.ingredients, let ingredients = try? JSONDecoder().decode([String].self, from: ingredientsData) {
            self.ingredients = ingredients
        } else {
            self.ingredients = []
        }
        self.yield = recipeEntity.yield
        self.totalTime = recipeEntity.totalTime        
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.recipeUrl == rhs.recipeUrl
    }
}
