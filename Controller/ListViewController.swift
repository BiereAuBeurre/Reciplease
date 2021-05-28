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
        super.viewWillAppear(animated)
//        ingredientsListLogic.browseRecipes()
//        tableView.dataSource = self
        print("JE LOAD LA DATA")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
//        ingredientsListLogic.browseRecipes()
        tableView.dataSource = self
//        tableView.reloadData()
    }
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("JE CREEE NOMBRE SECTION")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("JE CREEE NUMBER OF ROW IN SECTION")
        return IngredientsListLogic.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("JE CREE LA CELL")
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let recipe = IngredientsListLogic.recipes[indexPath.row]
        cell.textLabel?.text = recipe.name /* + " : " +  recipe.ingredients[0] */
//        cell.detailTextLabel?.text = recipe.ingredients[indexPath.row]
        return cell

    }
    
    
}
