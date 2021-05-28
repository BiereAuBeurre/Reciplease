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
        let url = "https://api.edamam.com/search?q=\(searchTerms)&app_key=b5144453065bd0a94728a7da37aa3548&app_id=d698f1a4"
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        print(encodedUrl)
        Session.default.request(encodedUrl).validate().responseDecodable(of: RecipesInfo.self) { (response) in
            completion(response.result)
        }
    }
    
    private (set) var recipes = [Recipe]()
    func add(recipe: Recipe) {
        recipes.append(recipe)
    }

}

//        AF.request(url).validate().response { response in
//            debugPrint(response)
//            guard let data = response.data else { return }
//            do {
//                let decodedData = try JSONDecoder().decode(RecipesInfo.self, from: data)
//                print(decodedData)
//            } catch let error {
//                print(error)
//            }
//        }
