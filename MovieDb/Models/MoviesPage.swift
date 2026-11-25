//
//  MoviesPage.swift
//  MovieDb
//
//  Created by Paul Drake on 11/15/26.
//

import Foundation

struct MoviesPage: Decodable {
    var page: Int
    var results: [Movies]
    var total_pages: Int
}
