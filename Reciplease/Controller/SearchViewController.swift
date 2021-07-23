//
//  ViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 24/05/2021.
//

import UIKit
import Alamofire

final class SearchViewController: UIViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var searchRecipesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var searchBar: UITextField! {
        didSet { searchBar?.addDoneToolBar() }
    }
    private var ingredientsArray = [String]()
    private var recipes: [Recipe] = []

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        clearList()
        self.activityIndicator.isHidden = true
        searchRecipesButton.addCornerRadius()
        clearButton.addCornerRadius()
        addIngredientButton.addCornerRadius()
        searchBar.adjustsFontForContentSizeCategory = true
        ingredientsList.adjustsFontForContentSizeCategory = true
    }
    
    private func ingredientsListformatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    
    private func clearList() {
        ingredientsList.text = ""
        ingredientsArray.removeAll()
    }
    
    private func pushRecipeList() {
        /// Checking ingredients as been added before looking for recipes.
        if ingredientsArray.isEmpty {
            showAlert("You forgot something", "Please add at least one ingredient to search recipes.")
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let listViewController = storyboard.instantiateViewController(identifier: "ListViewController") as? ListViewController else { return }
            listViewController.ingredients = ingredientsListformatted()
            listViewController.recipes = recipes
            listViewController.dataMode = .api
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(listViewController, animated: true)
        }
    }
    
    @IBAction func addIngredientsButton(_ sender: Any) {
        searchBar.closeKeyboard()
        /// First we're checking an ingredient is type to don't add an empty field to our URLRequest.
        guard searchBar.text != "" else { return showAlert("Please type an ingredient", "It seems you forgot to write an ingredient to look for.") }
        /// Unwrapping searchBar.text.
        guard let ingredient = searchBar.text else { return }
        ingredientsArray.append(ingredient)
        ingredientsList.text += "\n" + ingredient.capitalizingFirstLetter()
    }
    
    @IBAction func clearListButton(_ sender: Any) {
        clearList()
    }
    
    @IBAction func searchRecipesButton(_ sender: Any) {
        pushRecipeList()
    }
}

