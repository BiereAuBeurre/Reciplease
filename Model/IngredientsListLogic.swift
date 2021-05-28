//
//  IngredientList.swift
//  Reciplease
//
//  Created by Manon Russo on 26/05/2021.
//

import Foundation
import UIKit
class IngredientsListLogic {
    
    static var recipes: [Recipe] = []
    
    var ingredientsList: String = "" {
        didSet {
            notifyUpdate()
        }
    }
    var searchBar: String? = "" {
        didSet {
            notifyUpdate()
        }
    }
    
    var ingredientsArray: [String] = [] {
        didSet {
            notifyUpdate()
        }
    }
    
    func notifyUpdate() {
       let notificationName = Notification.Name("update")
       let notification = Notification(name: notificationName)
       NotificationCenter.default.post(notification)
   }
    
    func notifyAlert() {
        let notificationName = Notification.Name("alert")
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
    
    func clearList() {
       ingredientsList = ""
        ingredientsArray.removeAll()
    }
    
    func clearSearchBar() {
        searchBar = ""
    }
    
    func formattingList(_ ingredient: String) {
        ingredientsList += "\n" + ingredient.capitalizingFirstLetter()
    }

    func addIngredient(_ ingredient: String) {
        // Adding the ingredient currently type to the array of ingredients list
        ingredientsArray.append(ingredient)
        
        // Then we design the ingredient list look (only for user because we save it in our array)
        formattingList(ingredient)
        
        // We clear the search terms bar
        clearSearchBar()
    }
    
    private func ingredientsListformatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    func browseRecipes() {
        RecipeService.shared.fetchRecipes(for: ingredientsListformatted()) { result in
            switch result {
            case .success(let recipesResult):
                print(recipesResult)
                print(recipesResult.recipes.count)
                IngredientsListLogic.recipes = recipesResult.recipes
//                RecipeService.shared.add(recipe: recipesResult.recipes)
//                print(recipes.recipes.first!)
            case .failure(let error):
                print("Erreur :\(error)")
            }
        }
    }
    
}
