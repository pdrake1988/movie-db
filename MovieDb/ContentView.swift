//
//  ContentView.swift
//  MovieDb
//
//  Created by Paul Drake on 11/16/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MoviesPageView()
        }
    }
}

#Preview {
    ContentView()
}
