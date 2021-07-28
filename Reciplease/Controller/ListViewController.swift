//
//  ListViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 27/05/2021.
//

import UIKit
import Alamofire

// MARK: Enums
public enum DataMode {
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

final class ListViewController: UIViewController, UINavigationBarDelegate, UIScrollViewDelegate {
    
    // MARK: Properties
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let recipeService = RecipeService()
    var ingredients: String = ""
    var recipes: [Recipe] = []
    var dataMode: DataMode = .coreData
    
    var viewState: State<[Recipe]> = .loading {
        didSet {
            resetState()
            switch viewState {
            case .loading :
                activityIndicator.startAnimating()
                print("loading")
            case .empty :
                displayEmptyView()
                print("empty")
            case .error :
                showAlert("Error", "Something went wrong, try again please")
            case .showData (let recipes):
                print("datas are shown")
                self.recipes = recipes
                tableView.reloadData()
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
        if dataMode == .coreData && recipes.count != 0  {
        self.setUpDeleteButton()
        }
    }
    
    @objc func deleteAllFav() {
        for recipe in recipes {
            do { /// Deleting all recipes in the core data "memory".
                try StorageService.shared.deleteRecipe(recipe)
            } catch { print("Erreur: \(error)"); showAlert("Can't delete recipe", "Something went wrong, please try again later.") }
            /// Then delete from the datasource.
            recipes.removeAll()
            tableView.reloadData()
        }
        viewState = .empty
    }
    
    //MARK: Private methods
    private func resetState() {
        activityIndicator.stopAnimating()
        tableView.isHidden = true
    }
    private func setUpDataToLoad() {
        if dataMode == .coreData {
            do { recipes = try StorageService.shared.loadRecipes()
                if recipes.isEmpty {
                    viewState = .empty
                } else {
                    viewState = .showData(recipes)
                }
            } catch { print("erreur : \(error)"); showAlert("Can't load data", "Something wen wrong, please try again later.") }
        } else {
            fetchRecipes()
        }
    }
    
    private func setUpDeleteButton() {
        let navBarRightItem = UIBarButtonItem(
            title: "Remove all",
            style: .plain,
            target: self,
            action: #selector(deleteAllFav))
        navigationItem.rightBarButtonItem = navBarRightItem
    }
    
    private func setupView() {
        /// Clean extra useless separator for empty cells in fav.
        self.tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        title = dataMode.title
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
        
    private func displayEmptyView() {
        let emptyCaseTextView = UITextView.init(frame: self.view.frame)
        emptyCaseTextView.font = UIFont.preferredFont(forTextStyle: .headline)
        emptyCaseTextView.textAlignment = .center
        emptyCaseTextView.isEditable = false
        if dataMode == .coreData {
            emptyCaseTextView.text = "\n\n\n\n\nYou do not have favorites recipes yet !"
        } else {
            emptyCaseTextView.text = "\n\n\n\n\nNo recipe matching your search.\nTry something else please"
        }
        view.insertSubview(emptyCaseTextView, at: 0)
    }
    
    private func fetchRecipes() {
        viewState = .loading
        recipeService.fetchRecipes(for: ingredients) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let recipesInfo) where recipesInfo.recipes.isEmpty :
                    /// If the request works but does not find any recipes.
                    self.viewState = .empty
                case .success(let recipesInfo):
                    self.viewState = .showData(recipesInfo.recipes)
                case .failure(let error):
                    print("Erreur :\(error)")
                    self.showAlert("Error", "Can't load recipes. Please check your connection to internet and try again")
                }
            }
        }
    }
    
    private func displayRecipeDetailFor(_ recipe: Recipe) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController else { return }
        detailsViewController.recipe = recipe
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(detailsViewController, animated: true)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard dataMode == .coreData else { return nil }
        let action = UIContextualAction(style: .destructive, title: "Remove") { [weak self] (action, view, completionHandler) in
                do {
                    guard let recipes = self?.recipes else { return }
                    try StorageService.shared.deleteRecipe(recipes[indexPath.row])
                }
                catch {}
                self?.recipes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                if self?.recipes.isEmpty == true { self?.viewState = .empty }
                completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

