//
//  EdamamService.swift
//  Reciplease
//
//  Created by Manon Russo on 25/05/2021.
//

import Foundation
import Alamofire

class RecipeService {
    
    static let shared = RecipeService()
    private init() {}
    
    func fetchRecipes(for searchTerms: String, completion: @escaping (Result<RecipesInfo, AFError>) -> Void) {
        let url = "https://api.edamam.com/search?q=\(searchTerms)&app_key=b5144453065bd0a94728a7da37aa3548&app_id=d698f1a4&to=100"
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        print(encodedUrl)
        Session.default.request(encodedUrl).validate().responseDecodable(of: RecipesInfo.self) { (response) in
            completion(response.result)
        }
    }
}
