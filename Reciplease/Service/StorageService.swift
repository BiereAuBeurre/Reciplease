//
//  StorageService.swift
//  Reciplease
//
//  Created by Manon Russo on 25/06/2021.
//

import CoreData
class StorageService {
    //storage : test load delete et save, utiliser une autre bdd = coreDataBase en mémoire, pas persistée
    //créer persistent container en memoire et le passer poru qu'il soit utiliser, avoir fake recette dans fake data et le sauver, loader et delete

    static let sharedStorageService = StorageService()

    let viewContext: NSManagedObjectContext

    private init(persistentContainer: NSPersistentContainer = AppDelegate.persistentContainer) {
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
        recipeEntity.totalTime = recipe.totalTime ?? 16
        recipeEntity.yield = recipe.yield
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Show some error here
//                print(error)
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
