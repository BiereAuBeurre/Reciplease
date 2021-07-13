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

enum State<Data> {
    case loading
    case empty
    case error
    case showData(Data)
}

class ListViewController: UIViewController, UINavigationBarDelegate {
    var extraInfoView = ExtraInfoView()
    let activityIndicator = UIActivityIndicatorView(style: .large)

    let recipeService = RecipeService()
    var ingredients: String = ""
    var recipes: [Recipe] = []
    var dataMode: DataMode = .coreData

    
    var viewState: State<[Recipe]> = .loading {
        didSet {
            resetState()
            switch viewState {
            case .loading :
                tableView.isHidden = true
                activityIndicator.startAnimating()
                print("loading")
            case .empty :
                activityIndicator.stopAnimating()
                displayEmptyView()
                tableView.isHidden = true
                print("empty")
            case .error :
                showAlert("Error", "Something went wrong, try again please")
                print("error")/// remplacer par une alerte comme ça ?
            case .showData(let recipes) :
                print("datas are shown")
                self.recipes = recipes
                tableView.reloadData()
                activityIndicator.stopAnimating()
                tableView.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDataToLoad()
    }
    
    // MARK: - Methods
    private func setUpDataToLoad() {
        if dataMode == .coreData {
            do {
                recipes = try StorageService.sharedStorageService.loadRecipes()
                self.activityIndicator.stopAnimating()
                if recipes.isEmpty { viewState = .empty
                }
                else {
                    viewState = .showData(recipes)
                }
            } catch { print(error) }
        } else {
            fetchRecipes()
        }
    }
    
    private func setupView() {
        /// To clean extra useless separator for empty cells in fav
        self.tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemGray
        title = dataMode.title
        tableView.dataSource = self
        tableView.delegate = self
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func resetState() {} // ??
    
    private func displayEmptyView() {
        let backgroundImage = UITextView.init(frame: self.view.frame)
        backgroundImage.text = ""
        backgroundImage.font = UIFont.preferredFont(forTextStyle: .headline)
        backgroundImage.textAlignment = .center
        backgroundImage.isEditable = false
        if dataMode == .coreData {
            backgroundImage.text = "\n\n\nYou do not have favorites recipes yet !"
        } else {
            backgroundImage.text = "\n\nNo recipe found with those ingredients.\nTry something else please"
        }
        view.insertSubview(backgroundImage, at: 0)
    }
    
    private func fetchRecipes() {
        viewState = .loading
        recipeService.fetchRecipes(for: ingredients) { result in
            switch result {
//            case .success(let recipesInfo) where recipesInfo.recipes.isEmpty:
//                self.viewState = .empty
                
            case .success(let recipesInfo):
                self.recipes = recipesInfo.recipes
                self.viewState = .showData(recipesInfo.recipes)
                if recipesInfo.recipes.isEmpty {
                    self.viewState = .empty
                }
            case .failure(let error):
                print("Erreur :\(error)")
                self.showAlert("Error", "Can't load recipes. Please check your connection to internet and try again")
            }
        }
    }
    
    func displayRecipeDetailFor(_ recipe: Recipe) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController else { return }
        detailsViewController.recipe = recipe
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    @objc func dismissListController() {
        dismiss(animated: true, completion: nil)
    }
}
// MARK: - TableView config
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        displayRecipeDetailFor(selectedRecipe)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeCell else {
            assertionFailure("Dequeue TableView is of wrong type")
            return UITableViewCell()
        }
        cell.recipe = recipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard dataMode == .coreData else { return }
        if editingStyle == .delete {
            do {
                // deleting the recipe in the core data "memory"
                try StorageService.sharedStorageService.deleteRecipe(recipes[indexPath.row])
            } catch  {
                print("error")
            }
            // then delete the row from the datasource
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        // TODO: mettre à jour le coeur sur vue détails de la recette
        if recipes.isEmpty {
            viewState = .empty
        }
    }
}
