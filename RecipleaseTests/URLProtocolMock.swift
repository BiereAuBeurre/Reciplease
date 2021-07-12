//
//  URLProtocolMock.swift
//  RecipleaseTests
//
//  Created by Manon Russo on 08/07/2021.
//

import Foundation
import Alamofire

@testable import Reciplease


class UrlProtocolMock: URLProtocol {
    // this dictionary maps URLs to test data
    static var testURLs = [URL?: Data]()
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    
    
    override func startLoading() {
        // if we have a valid URL…
        if let url = request.url {
            // …and if we have test data for that URL…
            if let data = UrlProtocolMock.testURLs[url] {
                // …load it immediately.
                client?.urlProtocol(self, didLoad: FakeResponseData.getCorrectDataFor(resource: "Edamam"))
                self.client?.urlProtocol(self, didLoad: data)
                // unless we have an incorrect url then load error
            } else {
                client?.urlProtocol(self, didFailWithError: AFError.invalidURL(url: request.url!))
            }
        }
        //        switch response {}
        //        client?.urlProtocol(self, didFailWithError: AFError.invalidURL(url: request.url!))
        //        client?.urlProtocol(self, didLoad: FakeResponseData.getCorrectDataFor(resource: "Edamam"))
    }
        override func stopLoading() {}
}
