//
//  IngredientList.swift
//  Reciplease
//
//  Created by Manon Russo on 26/05/2021.
//

import Foundation

class IngredientsListLogic {
    
    var ingredientsList: String = "" {
        didSet {
            notifyUpdate()
        }
    }
    /// REPRENDRE ICI
    var searchBar: String = "" {
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
    }
    
    func clearSearchBar() {
        searchBar = ""
    }
    
    func formattingList(_ ingredient: String) {
        ingredientsList += "\n" + ingredient.capitalizingFirstLetter()
    }
    
    
}
