//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Manon Russo on 08/07/2021.
//

import Foundation
@testable import Reciplease

final class FakeResponseData {
        
    class FakeError: Error {}
    static let error = FakeError()
    
    static var recipe: [Recipe] {
        let recipeInfo = try! JSONDecoder().decode(RecipesInfo.self, from: recipeData)
        return recipeInfo.recipes
    }
    
    static var recipeData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Edamam", withExtension: "json")
        return try! Data(contentsOf: url!)
    }
    static let incorrectData = "erreur".data(using: .utf8)!
}
