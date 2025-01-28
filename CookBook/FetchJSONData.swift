//
//  FetchJSONData.swift
//  CookBook
//
//  Created by Shashank Rao on 1/28/25.
//
//{
//            "cuisine": "Malaysian",
//            "name": "Apam Balik",
//            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
//            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
//            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
//            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
//            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
//        }

import Foundation

struct Recipe: Identifiable, Codable {
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String
    let id: UUID
    let youtube_url: String
    
    
    enum CodingKeys: String, CodingKey{
        case cuisine
        case name
        case photo_url_large
        case photo_url_small
        case id
        case youtube_url
    }
}

struct RecipeListResponse: Codable {
    let recipes: [Recipe]
}
