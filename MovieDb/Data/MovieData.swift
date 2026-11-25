//
//  MovieData.swift
//  MovieDb
//
//  Created by Paul Drake on 11/15/26.
//

import Foundation

class MovieData {
    
    func getMovies(sortBy: String, withGenres: [String]?, page: Int) async throws -> MoviesPage {
        if let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] {
            var urlComponents = URLComponents(string: baseUrl)
            urlComponents?.path = "/3/discover/movie"
            urlComponents?.queryItems = withGenres == nil ? [
                URLQueryItem(name: "sort_by", value: sortBy),
                URLQueryItem(name: "page", value: String(page))
            ] : [
                URLQueryItem(name: "sort_by", value: sortBy),
                URLQueryItem(name: "with_genres", value: withGenres?.joined(separator: ", ")),
                URLQueryItem(name: "page", value: String(page))
            ]
            
            guard let accessToken = ProcessInfo.processInfo.environment["access_token"] else {
                throw NetworkError.invalidToken
            }
            
            guard let url = urlComponents?.url else {
                throw NetworkError.badUrl
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json", forHTTPHeaderField: "ContentType")
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = "GET"
            
            let (data, res) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = res as? HTTPURLResponse else {
                throw NetworkError.badResponse
            }
            
            if response.statusCode == 200 {
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(MoviesPage.self, from: data)
            } else {
                throw NetworkError.badResponse
            }
        } else {
            throw NetworkError.badUrl
        }
    }
}
