//
//  CookBookApp.swift
//  CookBook
//
//  Created by Shashank Rao on 1/26/25.
//

import SwiftUI

@main
struct CookBookApp: App {
    // Define different endpoints
    static let allRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    static let malformedRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    static let emptyRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    private let apiEndpoint = APICaller(apiURL: URL(string: emptyRecipes)!, cache: FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!)
    
    var body: some Scene {
        WindowGroup {
            CookBookUI(apicaller: apiEndpoint)
        }
    }
}
