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
            return "Result"
        case .coreData :
            return "Favorites"
        }
    }
}

class ListViewController: UIViewController {
    
    var recipes: [Recipe] = []
    var dataMode: DataMode = .api
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tableView.dataSource = self
        print("JE LOAD LA DATA")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = dataMode.title
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        tableView.dataSource = self
    }
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("JE CREEE NOMBRE SECTION")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("JE CREEE NUMBER OF ROW IN SECTION")
        return recipes.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        print("JE CREE LA CELL")
        let recipe = recipes[indexPath.row]

        cell.textLabel?.text = recipe.name /* + " : " +  recipe.ingredients[0] */
//        cell.detailTextLabel?.text = recipe.ingredients[indexPath.row]
        return cell

    }
    
    
}
