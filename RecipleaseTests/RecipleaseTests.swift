//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Manon Russo on 24/05/2021.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipleaseTests: XCTestCase {
    var session: Session!
    var networkService: RecipeService!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolMock.self]
        session = Session(configuration: configuration)
        networkService = RecipeService(session: session)
    }

    func testGetRecipesShouldPostFailedCompletionIfError() throws {
        // When :
        networkService.fetchRecipes(for: FakeResponseData.badUrl) { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testItWorkWithGoodData() throws {
        networkService.fetchRecipes(for: "chicken egg avocado cheese rosemary coconut") { (result) in
            guard case .success(let success) = result else { return }
            XCTAssertNotNil(success)

        }
    }


    func testGetRecipesShouldPostFailedCompletionIfIncorrectData() throws {
        // Given :
        // When :
        networkService.fetchRecipes(for: "chicken egg avocado cheese rosemary coconut") { (result) in
            // Then :
            guard case .failure(let error) = result else {
                return
            }
            XCTAssertNotNil(error)
        }
    }
}
