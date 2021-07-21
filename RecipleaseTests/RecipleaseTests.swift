//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Manon Russo on 24/05/2021.
//

import XCTest
@testable import Alamofire
@testable import Reciplease

final class RecipleaseTests: XCTestCase {
    var session: Session!
    var networkService: RecipeService!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolMock.self]
        session = Session(configuration: configuration)
        networkService = RecipeService(session: session)
    }
    
    override func tearDownWithError() throws {
        UrlProtocolMock.data = nil
        UrlProtocolMock.error = nil
    }
    
    func testGetRecipesShouldPostFailed() throws {
        UrlProtocolMock.error = AFError.explicitlyCancelled
        let expectation = XCTestExpectation(description: "get recipes")
        networkService.fetchRecipes(for: "chicken") { (result) in
            guard case .failure(let error) = result else {
                XCTFail("missing failure error")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetRecipesShouldWork() throws {
        UrlProtocolMock.data = FakeResponseData.recipeData
        let expectation = XCTestExpectation(description: "get recipes")
        networkService.fetchRecipes(for: "pasta") { (result) in
            guard case .success(let recipes) = result else {
                XCTFail("missing success data")
                return
            }
            XCTAssertNotNil(recipes)
            let recipe = try! XCTUnwrap(recipes.recipes.first, "missing recipe")
            XCTAssertEqual(recipe.name, "The Crispy Egg")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
}
