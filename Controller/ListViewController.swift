//
//  ListViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 27/05/2021.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {
    var ingredientsListLogic = IngredientsListLogic()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        ingredientsListLogic.browseRecipes()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
//        ingredientsListLogic.browseRecipes()
        tableView.reloadData()

    }
}
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return RecipeService.shared.recipes.count
        return IngredientsListLogic.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let recipe = IngredientsListLogic.recipes[indexPath.row]
//        let recipe = RecipeService.shared.recipes[indexPath.row]
        cell.textLabel?.text = recipe.name + " : " +  recipe.ingredients[0]
//        cell.detailTextLabel?.text = recipe.ingredients[indexPath.row]
        return cell

    }
}
