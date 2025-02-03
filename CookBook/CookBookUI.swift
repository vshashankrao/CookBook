//
//  CookBookUI.swift
//  CookBook
//
//  Created by Shashank Rao on 1/30/25.
//

import SwiftUI

struct CookBookUI: View {
    // Recipe List and API Caller definitions
    @State private var recipes: [Recipe] = []
    @State private var isLoading = false
    private let apicaller: APICaller
    
    init(apicaller: APICaller) {
        self.apicaller = apicaller
    }
    
    // View flow is as follows NavView -> VStack -> HStack -> VStack
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading Recipes...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List(recipes) { recipe in
                        HStack {
                            AsyncImage(url: URL(string: recipe.photo_url_large)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            // Each Recipe/Cuisine
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)
                                Text(recipe.cuisine)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .refreshable {
                        await loadRecipes()
                    }
                }
            }
            .onAppear {
                Task {
                    await loadRecipes()
                }
            }
            .navigationTitle("Recipes")
        }
        Image(systemName: "fork.knife")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Text("Cook Book").font(.largeTitle)
    }
    
    // Load the recipes
    private func loadRecipes() async {
        isLoading = true
        do {
            recipes = try await apicaller.fetchRecipes()
        } catch {
            // Error Handling
            print("Error fetching recipes: \(error)")
        }
        isLoading = false
    }
}

private let apiEndpoint = APICaller(apiURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!, cache: FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!)
#Preview {
    CookBookUI(apicaller: apiEndpoint)
}
