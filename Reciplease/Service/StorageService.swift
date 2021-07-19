//
//  StorageService.swift
//  Reciplease
//
//  Created by Manon Russo on 25/06/2021.
//

import CoreData

class StorageService {

    static let shared = StorageService()
    let viewContext: NSManagedObjectContext

    init(persistentContainer: NSPersistentContainer = AppDelegate.persistentContainer) {
        // passer un persistentContainer par défaut
        self.viewContext = persistentContainer.viewContext
    }
    
    func loadRecipes() throws -> [Recipe] {
//     requete coreData, retourne objet recipeEntity converti en recipe dès que c'est loadé
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let recipeEntities: [RecipeEntity]
        do {
            recipeEntities = try viewContext.fetch(fetchRequest)
        } catch {
            throw error
        }
        //convertir en boucle et implémenter le loadrecipes et favorites
        let recipes = recipeEntities.map { (recipeEntity) -> Recipe in
            return Recipe(from: recipeEntity)
        }
        return recipes
     }
    
    func saveRecipe(_ recipe: Recipe) throws {
        let recipeEntity = RecipeEntity(context: viewContext)
        recipeEntity.name = recipe.name
        recipeEntity.imageUrl = recipe.imageUrl
        recipeEntity.recipeUrl = recipe.recipeUrl
        recipeEntity.ingredients = recipe.ingredients.joined(separator: ",")
        recipeEntity.totalTime = recipe.totalTime
        recipeEntity.yield = recipe.yield
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Show some error here
                throw error
            }
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) throws {
        
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", recipe.name)
        fetchRequest.predicate = predicate
        
        let recipeEntities: [RecipeEntity]

        do {
            recipeEntities = try viewContext.fetch(fetchRequest)
            recipeEntities.forEach { (recipeEntity) in
                viewContext.delete(recipeEntity)
            }
            // save une fois que c'est supprimé
            try viewContext.save()
        } catch {
            throw error
        }
        
    }
}
