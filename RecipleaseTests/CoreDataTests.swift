//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Manon Russo on 13/07/2021.
//
import CoreData
import XCTest
@testable import Reciplease

class CoreDataTests: XCTestCase {
    var storageService: StorageService!
    
    override func setUp() {
        super.setUp()
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.shouldAddStoreAsynchronously = true
        
        let persistentContainer = NSPersistentContainer(name: "Reciplease", managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { description, error in
            precondition(description.type == NSInMemoryStoreType, "Store description is not of type NSInMemoryStoreType")
            if let error = error as NSError? {
                fatalError("Persistent container creation failed : \(error.userInfo)")
            }
        }
        
        storageService = StorageService(persistentContainer: persistentContainer)
        
    }
    
    override func tearDown() {
        storageService = nil
        super.tearDown()
    }
    
    func testRecipeLoading() {
        var loadedRecipes: [Recipe] = []
        
        let recipe = FakeResponseData.recipe.first!
        // faire une boucle for each recipes
        do {
            try storageService.saveRecipe(recipe)
        } catch {
            XCTFail("error saving \(error.localizedDescription)")
        }
        
        do {
           loadedRecipes = try storageService.loadRecipes()
        } catch {
            XCTFail("error saving \(error.localizedDescription)")
        }
        XCTAssertFalse(loadedRecipes.isEmpty, "")
        //tableau.count = le bon nombre de recettes, première recette avec le nom
    }
    func testRecipeDeletion() {}
}
