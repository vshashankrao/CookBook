//
//  ContentView.swift
//  CookBook
//
//  Created by Shashank Rao on 1/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Cook Book").font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
