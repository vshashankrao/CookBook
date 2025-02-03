//
//  Recipe.swift
//  CookBook
//
//  Created by Shashank Rao on 1/28/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String
    let id: UUID
    let youtube_url: String?
    
    
    enum CodingKeys: String, CodingKey{
        case cuisine
        case name
        case photo_url_large
        case photo_url_small
        case id = "uuid"
        case youtube_url
    }
}

struct RecipeListResponse: Codable {
    let recipes: [Recipe]
}
