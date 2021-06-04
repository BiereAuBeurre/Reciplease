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
    @IBOutlet weak var durationLabel: UILabel!
    
    
        override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
