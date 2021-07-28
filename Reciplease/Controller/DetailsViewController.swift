//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 25/06/2021.
//

import UIKit
import SafariServices

final class DetailsViewController: UIViewController, SFSafariViewControllerDelegate {
    var recipe: Recipe?
    private var isRecipeFavorite = false
    private var extraInfoView = ExtraInfoView()
    
    @IBOutlet weak var ingredientsTitle: UILabel!
    @IBOutlet weak var backgroundPicture: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var ingredients: UITextView!
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteState()
        setUpFavoriteButton()
        extraInfoView.recipe = recipe
        extraInfoView.configureView()
    }
    
    
    // MARK: - Methods
    
    private func setUpView() {
        button.addCornerRadius()
        
        recipeName.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        recipeName.numberOfLines = 0
        recipeName.text = recipe?.name
        
        ingredients.adjustsFontForContentSizeCategory = true
        ingredients.text =  "- \(recipe?.ingredients.joined(separator: "\n- ") ?? "not available")"
        ingredients.font = UIFont.preferredFont(forTextStyle: .body)
        
        ingredientsTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        ingredientsTitle.text = "👨‍🍳 What you'll need :"
  
        if let loadedBackgroundPicture = recipe?.imageUrl {
            backgroundPicture.loadImage(loadedBackgroundPicture)
        } else {
            backgroundPicture.image = UIImage(named: "defaultRecipe")
        }
        extraInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(extraInfoView)
        view.bringSubviewToFront(extraInfoView)

        NSLayoutConstraint.activate([
            backgroundPicture.trailingAnchor.constraint(equalTo: extraInfoView.trailingAnchor, constant: 2),
            extraInfoView.topAnchor.constraint(equalTo: backgroundPicture.topAnchor, constant:100),
        ])
    }
    
    private func addToFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService.shared.saveRecipe(recipe)
            fetchFavoriteState()
        } catch {
            print("erreur : \(error)"); showAlert("Can't save recipe to favorite", "Please try again later")
        }
    }
    
    private func removeFromFavorite() {
        guard let recipe = recipe else { return }
        do {
            try StorageService.shared.deleteRecipe(recipe)
            isRecipeFavorite = false
            
        } catch {
            print("erreur: \(error)"); showAlert("Something went wrong", "Can't remove recipe from favorites right now. Please ty again later.")
        }
    }
    
    private func fetchFavoriteState() {
        guard let recipe = recipe else { return }
        let recipes = try? StorageService.shared.loadRecipes()
        guard let _ = recipes?.first(where: { $0 == recipe }) else { isRecipeFavorite = false; return }
        isRecipeFavorite = true
    }
    
    private func setUpFavoriteButton() {
        let navBarRightItem = UIBarButtonItem(
            image: UIImage(systemName: isRecipeFavorite ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = navBarRightItem
    }
    
    @objc func toggleFavorite() {
        /// Check if the recipe is already marked as favorite, then add it or remove it from our recipe entity (our favorite data base)
        if isRecipeFavorite {
            // suppression du favori
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            removeFromFavorite()
            isRecipeFavorite = false
        } else if isRecipeFavorite == false {
            // ajout du favori
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            addToFavorite()
            isRecipeFavorite = true
        }
    }
    
    /// Display full recipes on its website in safari.
    @objc func openRecipeWebsite() {
        guard let urlString = recipe?.recipeUrl else { return }
        if let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            present(safariViewController, animated: true)
        }
    }
    
    @IBAction func didTapGetDirectionsButton(_ sender: Any) {
        openRecipeWebsite()
    }
    
}
