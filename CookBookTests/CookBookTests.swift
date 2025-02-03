//
//  CookBookTests.swift
//  CookBookTests
//
//  Created by Shashank Rao on 1/26/25.
//

import Testing
import XCTest
@testable import CookBook

class CookBookTests: XCTestCase {

//    @Test func example() async throws {
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    }

    static let allRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    static let malformedRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    static let emptyRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    func testFetchRecipes() async throws{
        let testURL = URL(string: CookBookTests.allRecipes)!
//        let testURL = URL(string: CookBookTests.malformedRecipes)!
//        let testURL = URL(string: CookBookTests.emptyRecipes)!
        let testAPICall = APICaller(apiURL: testURL, cache: FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!)
        
        
        let recipes = try await testAPICall.fetchRecipes()
                
        XCTAssertNotNil(recipes)
        XCTAssertGreaterThan(recipes.count, 0)
    }
    
    func testCaching() async throws{
        let testURL = URL(string: CookBookTests.allRecipes)!
//        let testURL = URL(string: CookBookTests.malformedRecipes)!
//        let testURL = URL(string: CookBookTests.emptyRecipes)!
        let testAPICall = APICaller(apiURL: testURL, cache: FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!)
        
        
        let imageData = try await testAPICall.processImage(from: testURL)
        let cache = try await testAPICall.processImage(from: testURL)
                
        XCTAssertEqual(imageData, cache)
    }
}
