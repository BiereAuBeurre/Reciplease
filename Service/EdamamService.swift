//
//  EdamamService.swift
//  Reciplease
//
//  Created by Manon Russo on 25/05/2021.
//

import Foundation
import Alamofire

class EdamamService {

    
    func searchingRecipesFor(_ searchTerms: String) {
        let url = "https://api.edamam.com/search?q=\(searchTerms)&app_key=b5144453065bd0a94728a7da37aa3548&app_id=d698f1a4&"
        
        AF.request(url).response { response in
            debugPrint(response)
        }
    }

/*
    func fetchWeatherDataFor(_ cityId: String, completion: @escaping (Result<MainWeatherInfo, ServiceError>) -> Void) {
        guard let openWeatherUrl = URL(string: loadCity(cityId)) else { return completion(.failure(.invalidUrl)) }
        // If a task is already ongoing, we're canceling it before creating a new one (secured on UI with activity indicator).
        task?.cancel()
        task = urlSession.dataTask(with: openWeatherUrl) { (data, response, error) in
            let result = self.handleResponse(dataType: MainWeatherInfo.self, data, response, error)
            completion(result)
        }
        task?.resume() // This method start the task previously defined (newly initialized task begin in a suspended state).
    }
*/
}
