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
    let totalTime: Double? // 0.0 pour nil chez certains à remplacer
    let yield: Double
    
    let ingredients: [String] // à convertir en string unique
        
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
        let decodedTotalTime = try recipe.decode(Double.self, forKey: .totalTime)
        totalTime = decodedTotalTime == 0.0 ? nil : decodedTotalTime
//        ingredients = ingredients.joined(separator:",")
        yield = try recipe.decode(Double.self, forKey: .yield)
    }
}

extension Recipe {
    init(from recipeEntity: RecipeEntity) {
        self.name = recipeEntity.name ?? ""
        self.recipeUrl = recipeEntity.recipeUrl ?? ""
        self.imageUrl = recipeEntity.imageUrl ?? ""
        self.ingredients = recipeEntity.ingredients?.components(separatedBy: ",") ?? []
 

//        self.ingredients = Array(recipeEntity.ingredients?)
//        self.ingredients = (recipeEntity.ingredients?.components(separatedBy: ", \n - "))!
//        self.ingredients.joined() = recipeEntity.ingredients // faire l'inverse de joined()
        
        self.yield = recipeEntity.yield
        self.totalTime = recipeEntity.totalTime
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.recipeUrl == rhs.recipeUrl
        // modif réalisée : Ajouter comparaison de l'URL également, plus safe que le nom seul
        //anciennement
//            return lhs.name == rhs.name
    }
}

struct Ingredients: Decodable {
    let text: String
    let weight: Double
    let image: String?
}
