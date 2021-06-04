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
    var ingredientsArray = [String]()
    var recipes: [Recipe] = []

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearList()
        self.activityIndicator.isHidden = true

    }
    
    private func ingredientsListformatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    private func fetchRecipes() {
        searchRecipesButton.isHidden = true
        activityIndicator.isHidden = false
        RecipeService.shared.fetchRecipes(for: ingredientsListformatted()) { result in
            self.activityIndicator.isHidden = true
            self.searchRecipesButton.isHidden = false
            switch result {
            case .success(let recipesInfo):
                print(recipesInfo)
                print(recipesInfo.recipes.count)
                self.recipes = recipesInfo.recipes
                self.pushRecipeList()

            case .failure(let error):
                print("Erreur :\(error)")
            }
        }
    }
    
    private func clearList() {
        ingredientsList.text = ""
        ingredientsArray.removeAll()
    }
    
    func pushRecipeList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let listViewController = storyboard.instantiateViewController(identifier: "ListViewController") as? ListViewController else { return }
        listViewController.recipes = recipes
        listViewController.dataMode = .api
        listViewController.modalPresentationStyle = .currentContext
        self.present(listViewController, animated: true)
    }
    
    @IBAction func addIngredientsButton(_ sender: Any) {
        searchBar.closeKeyboard()
        // First we're checking an ingredient is type to don't add an empty field to our URLRequest
        guard searchBar.text != "" else { return showAlert("Please add an ingredient", "It seems you forgot to add one 😉") }
        // Unwrapping searchBar.text
        guard let ingredient = searchBar.text else { return }
        ingredientsArray.append(ingredient)
        ingredientsList.text += "\n" + ingredient.capitalizingFirstLetter()
    }
    
    @IBAction func clearListButton(_ sender: Any) {
        clearList()
    }
    
    @IBAction func searchRecipesButton(_ sender: Any) {
        print("JE FAIS L'APPEL RESEAU")
        fetchRecipes()
    }
    
//    @objc func ingredientsListUpdated() {
//        ingredientsList.text = ingredientsListLogic.ingredientsList
//        searchBar.text = ingredientsListLogic.searchBar
//        ingredientsArray = ingredientsListLogic.ingredientsArray
//    }
//
//    @objc func notifyAlert() {
//        showAlert("Please add an ingredient", "It seems you forgot to add one 😉")
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let dataController = segue.destination as? ListViewController {
//            dataController.dataRecipe = self.dataRecipe
//            dataController.ingredients = ingredients
//            dataController.recipes = recipes
//        }
//    }
    
}

