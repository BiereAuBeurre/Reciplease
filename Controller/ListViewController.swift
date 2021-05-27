//
//  ListViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 27/05/2021.
//

import UIKit

class ListViewController: UITabBarController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
//
//class UITableView: UIScrollView {
//    weak var dataSource: UITableViewDataSource?
//}
//
//protocol UITableViewDataSource: class {
//    func numberOfSections(in tableView: UITableView) -> Int
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    // (...)
//}
