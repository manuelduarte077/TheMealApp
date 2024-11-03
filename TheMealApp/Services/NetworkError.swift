//
//  NetworkError.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case badResponse
}
