//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Manon Russo on 08/07/2021.
//

import Foundation

final class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: nil)!
    static let badUrl = "@:)à"
    
    
    class FakeError: Error {}
    static let error = FakeError()
    
    
    static func getCorrectDataFor(resource: String) -> Data { // Méthode intelligente
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: resource, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectData = "erreur".data(using: .utf8)!
}
