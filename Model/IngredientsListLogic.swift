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
    
    func notifyUpdate() {
       let notificationName = Notification.Name("update")
       let notification = Notification(name: notificationName)
       NotificationCenter.default.post(notification)
   }
    
    func clearList() {
       ingredientsList = ""
    }
    
    
}
