//
//  ViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 24/05/2021.
//

import UIKit
import Alamofire
class SearchViewController: UIViewController {
    
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
        // Do any additional setup after loading the view.
        clearList()
        self.activityIndicator.isHidden = true
        
        searchRecipesButton.addCornerRadius()
        clearButton.addCornerRadius()
        addIngredientButton.addCornerRadius()
    }
    
    private func ingredientsListformatted() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    private func clearList() {
        ingredientsList.text = ""
        ingredientsArray.removeAll()
    }
    
    func pushRecipeList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let listViewController = storyboard.instantiateViewController(identifier: "ListViewController") as? ListViewController else { return }
        listViewController.ingredients = ingredientsListformatted()
        listViewController.recipes = recipes
        listViewController.dataMode = .api
        
//        if listViewController.recipes.isEmpty {
//            listViewController.viewState = .empty
//        }
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(listViewController, animated: true)
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
        pushRecipeList()
    }
}

