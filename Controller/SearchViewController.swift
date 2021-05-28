//
//  ViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 24/05/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchRecipesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var searchBar: UITextField! {
        didSet { searchBar?.addDoneToolBar() }
    }
    var dataRecipe: RecipesInfo?
    var ingredientsArray = [String]()
    var ingredientsListLogic = IngredientsListLogic()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ingredientsListUpdated), name: Notification.Name("update"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyAlert), name: Notification.Name("alert"), object: nil)
        
        // Do any additional setup after loading the view.
        ingredientsListLogic.clearList()
        self.activityIndicator.isHidden = true

    }
    
    private func ingredientsListformatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    
    @IBAction func addIngredientsButton(_ sender: Any) {
        searchBar.closeKeyboard()
        // First we're checking an ingredient is type to don't add an empty field to our URLRequest
        guard searchBar.text != "" else { return notifyAlert() }
        // Unwrapping searchBar.text
        guard let ingredient = searchBar.text else { return }
        ingredientsListLogic.addIngredient(ingredient)
    }
    
    @IBAction func clearListButton(_ sender: Any) {
        ingredientsListLogic.clearList()
    }
    
    @IBAction func searchRecipesButton(_ sender: Any) {
        print("JE FAIS L'APPEL RESEAU")
        searchRecipesButton.isHidden = true
        activityIndicator.isHidden = false
//        ingredientsListLogic.browseRecipes()
        RecipeService.shared.fetchRecipes(for: ingredientsListformatted()) { result in
            switch result {
            case .success(let recipesResult):
                print(recipesResult)
                print(recipesResult.recipes.count)
                IngredientsListLogic.recipes = recipesResult.recipes
                self.dataRecipe = recipesResult
//                RecipeService.shared.add(recipe: recipesResult.recipes)
//                print(recipes.recipes.first!)
                self.activityIndicator.isHidden = true
                self.searchRecipesButton.isHidden = false
                self.performSegue(withIdentifier: "SearchToResult", sender: nil)
            case .failure(let error):
                print("Erreur :\(error)")
            }
        }
    }
    
    @objc func ingredientsListUpdated() {
        ingredientsList.text = ingredientsListLogic.ingredientsList
        searchBar.text = ingredientsListLogic.searchBar
        ingredientsArray = ingredientsListLogic.ingredientsArray
    }
    
    @objc func notifyAlert() {
        showAlert("Please add an ingredient", "It seems you forgot to add one 😉")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataController = segue.destination as? ListViewController {
            dataController.dataRecipe = self.dataRecipe
//            dataController.ingredients = ingredients
//            dataController.recipes = recipes
        }
    }
    
}

