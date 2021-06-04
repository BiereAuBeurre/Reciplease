//
//  ListViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 27/05/2021.
//

import UIKit
import Alamofire


enum DataMode {
    case api
    case coreData
    var title: String {
        switch self {
        case .api :
            return "Search results"
        case .coreData :
            return "Favorites"
        }
    }
}

class ListViewController: UIViewController, UINavigationBarDelegate {
    
    var recipes: [Recipe] = []
    var dataMode: DataMode = .api
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        let navigationItem = UINavigationItem()
        navigationItem.title = "\(recipes.count) \(dataMode.title)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action:#selector(self.dismissListController))
        navigationBar.items = [navigationItem]
        view.addSubview(navigationBar)
        // Do any additional setup after loading the view.
        tableView.dataSource = self
//        self.navigationController?.isNavigationBarHidden = false

    }
    @objc func dismissListController() {
        dismiss(animated: true, completion: nil)
    }
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("JE CREEE NUMBER OF ROW IN SECTION")
        return recipes.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        let totalTime = Int(recipe.totalTime ?? 15)
        if let cellCustom = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? RecipeCell {
            cellCustom.recipeTitle.text = recipe.name
            cellCustom.recipeIngredient.text = "\(recipe.ingredients.joined(separator: ", "))."
            cellCustom.background.loadImage(recipe.imageUrl ?? "https://oceanrecipes.com/wp-content/uploads/2020/04/Cover-scaled.jpg")
            cellCustom.durationLabel.text = "\(totalTime) min"
            return cellCustom
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
            return cell
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
//        print("JE CREE LA CELL")
//        let recipe = recipes[indexPath.row]

//        cell.textLabel?.text = recipe.name /* + " : " +  recipe.ingredients[0] */
//        cell.detailTextLabel?.text = recipe.ingredients[indexPath.row]
//        cell.imageView?.loadImage(recipe.imageUrl!)
//        return cell
    }
    
}
