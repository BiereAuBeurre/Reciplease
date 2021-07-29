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
    
    func fetchRecipes(for searchTerms: String, from: Int, completion: @escaping (Result<RecipesInfo, AFError>) -> Void) {
        let url = "https://api.edamam.com/search?q=\(searchTerms)&app_key=\(ApiConfiguration.key)&app_id=\(ApiConfiguration.id)&from=\(from)&to=100"
        /// Handle food terms of two words ("cherry tomato" for example).
        let encodedUrl = url.replacingOccurrences(of: " ", with: "+")
        print("requesting recipes for : \(searchTerms). With url : \(encodedUrl)")
        session.request(encodedUrl).validate().responseDecodable(of: RecipesInfo.self) { (response) in
            completion(response.result)
        }
    }
}
