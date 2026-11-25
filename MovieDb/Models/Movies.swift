//
//  Movies.swift
//  MovieDb
//
//  Created by Paul Drake on 11/15/26.
//

import Foundation

struct Movies: Decodable, Identifiable {
    let id: Int
    let backdrop_path: String
    let genre_ids: [Int]
    let title: String
    let original_language: String
    let overview: String
    let popularity: Float
    let poster_path: String
    let release_date: String
}
