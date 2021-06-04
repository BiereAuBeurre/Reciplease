//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Manon Russo on 04/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeIngredient: UILabel!
    
//    var recipe: Recipe! {
//        didSet {
//
//            background.loadImage(recipe.imageUrl ?? "https://oceanrecipes.com/wp-content/uploads/2020/04/Cover-scaled.jpg")
//            recipeTitle.text = recipe.name
//            recipeIngredient.text = recipe.ingredients.joined(separator: ",")
//            
//        }
//    }
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
        // Initialization code
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
