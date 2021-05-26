//
//  ViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 24/05/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var searchBar: UITextField! {
        didSet { searchBar?.addDoneToolBar() }
    }
    
    var ingredientsArray = [String]()
    var recipes: RecipesInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingredientsList.text = nil
//        RecipeService().searchRecipesFor(mutateStringArray()) { result in
//            switch result {
//            case .success(let recipes):
//                print(recipes)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func mutateStringArray() -> String {
        return ingredientsArray.joined(separator: ",")
    }
    
    @IBAction func addIngredientsButton(_ sender: Any) {
        searchBar.closeKeyboard()
        guard searchBar.text != "" else { return showAlert("Please add an ingredient", "It seems you forgot to add an ingredient 😉") }
        guard let ingredient = searchBar.text else { return }
        // Adding the ingredient currently type to the array of ingredients list
        ingredientsArray.append(ingredient)
        
        // Then we design the ingredient list look (only for user because we save it in our array)
        ingredientsList.text += "\n" + ingredient
        
        // We clear the search terms bar
        searchBar.text = nil
        
        // Maybe not necessary thanks to the append
//        let index = ingredientsArray.count
//        if ingredientsArray.count == 1 {
//            ingredientsArray[0] = ingredient
//        } else /*if ingredientsArray.count > 1 */{
//            ingredientsArray[index-1] = ingredient
//        }
        
    }
    
    @IBAction func clearListButton(_ sender: Any) {
        ingredientsList.text = ""
    }
    
    @IBAction func searchRecipesButton(_ sender: Any) {
//        RecipeService().searchRecipesFor(ingredientsList.text) { result in
        RecipeService().searchRecipesFor(mutateStringArray()) { result in

            switch result {
            case .success(let recipes):
                print(recipes)
                print(recipes.recipes.count)
            case .failure(let error):
                print(error)
            }
        }
    }
}

