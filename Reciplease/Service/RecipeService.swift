//
//  EdamamService.swift
//  Reciplease
//
//  Created by Manon Russo on 25/05/2021.
//

import Alamofire

class RecipeService {
    private let session: Session
    init(session: Session = .default) {
        self.session = session
    }
    
    let key = "b5144453065bd0a94728a7da37aa3548"
    let id = "d698f1a4"
    
    func fetchRecipes(for searchTerms: String, completion: @escaping (Result<RecipesInfo, AFError>) -> Void) {
        let url = "https://api.edamam.com/search?q=\(searchTerms)&app_key=\(key)&app_id=\(id)&to=100"
//
        /// Handle food terms of two words ("cherry tomato" for example).
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        print("requesting recipes for : \(searchTerms). With url : \(encodedUrl)")
        session.request(encodedUrl).validate().responseDecodable(of: RecipesInfo.self) { (response) in
            completion(response.result)
        }
    }
}
