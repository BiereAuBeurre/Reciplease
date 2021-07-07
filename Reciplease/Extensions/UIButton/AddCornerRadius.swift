//
//  AddCornerRadius.swift
//  Reciplease
//
//  Created by Manon Russo on 04/06/2021.
//

import UIKit

extension UIButton {
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
}
