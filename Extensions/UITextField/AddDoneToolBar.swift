//
//  AddDoneToolBar.swift
//  Reciplease
//
//  Created by Manon Russo on 26/05/2021.
//

import UIKit
extension UITextField {
    // This method is defining the button toolbar of the keyboard and its action.
    func addDoneToolBar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Fermer", style: .plain, target: self.target, action: #selector(closeKeyboard))
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    // Default action:
    @objc func closeKeyboard() { self.resignFirstResponder() }
}
