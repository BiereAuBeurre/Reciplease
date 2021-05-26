//
//  ViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 24/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        RecipeService().searchingRecipesFor("chicken") { result in
            switch result {
            case .success(let recipes):
                print(recipes)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

