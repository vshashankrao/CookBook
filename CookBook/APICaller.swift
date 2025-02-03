//
//  APICaller.swift
//  CookBook
//
//  Created by Shashank Rao on 1/28/25.
//

import Foundation
import SwiftUI
import UIKit

class APICaller{
    private let cache: URL
    private let baseURL: URL
    
    init(apiURL: URL, cache: URL){
        self.baseURL = apiURL
        self.cache = cache
    }
    
    // send API Request
    func fetchRecipes() async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: baseURL)
        let jsonresponse = try JSONDecoder().decode(RecipeListResponse.self, from: data)
        return jsonresponse.recipes
    }
    
    // process and load images
    func processImage(from url: URL) async throws -> Data{
        let cachedURL = cache.appendingPathComponent(url.lastPathComponent)
        
        if let cachedImage = try? Data(contentsOf: cachedURL){
            return cachedImage
        }
        
        do {
            // download image if not cached
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // try to cache the image data
            do {
                try data.write(to: cachedURL)
            } catch {
                // handle image caching error
                print("Failed to cache image: \(error)")
            }
            
            return data
        } catch {
            // handle network error
            print("Failed to download image: \(error)")
            throw error  // rethrow the error if you want to propagate it
        }
    }
    
}
