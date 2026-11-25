//
//  MoviesPageView.swift
//  MovieDb
//
//  Created by Paul Drake on 11/16/26.
//

import SwiftUI

struct MoviesPageView: View {
    @State private var sortBy: String = "popularity.desc"
    @State private var withGenres: [String]? = nil
    @State private var page: Int = 1
    @State private var scrollPosition = ScrollPosition()
    @State private var moviesPage: MoviesPage?
    
    private let columns = [
        GridItem(.fixed(120), spacing: 40, alignment: .center),
        GridItem(.fixed(120), spacing: 40, alignment: .center),
    ]
    private let imageUrl = "https://image.tmdb.org/t/p/w154"
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    if let movies = $moviesPage.wrappedValue?.results {
                        ForEach(movies, id: \.id) { movie in
                            AsyncImage(url: URL(string: imageUrl + movie.poster_path)) { img in
                                img.image?.frame(maxWidth: 70, maxHeight: 250)
                            }
                        }
                    } else {
                        ErrorView()
                    }
                }.scrollTargetLayout()
            }.task {
                do {
                    let movieData = MovieData()
                    moviesPage = try await movieData.getMovies(sortBy: sortBy, withGenres: withGenres, page: page)
                } catch {
                    moviesPage = nil
                }
            }.scrollPosition($scrollPosition)
        }
    }
}

#Preview {
    MoviesPageView()
}
