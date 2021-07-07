//
//  CapitalizingFirstLetter.swift
//  Reciplease
//
//  Created by Manon Russo on 26/05/2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
            return prefix(1).capitalized + dropFirst()
        /// Example : translating "Bonjour" to "Hello"
        /// prefix(1).capitalized is "H", dropFirst() is "ello"
        }
    
}
