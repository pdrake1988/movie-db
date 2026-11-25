//
//  NetworkError.swift
//  MovieDb
//
//  Created by Paul Drake on 11/22/26.
//

enum NetworkError: Error {
    case badUrl
    case invalidToken
    case badResponse
    case unauthorized
}
