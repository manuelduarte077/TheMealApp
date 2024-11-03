//
//  NetworkService.swift
//  TheMealApp
//
//  Created by Manuel Duarte on 3/11/24.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        return data
    }
}
