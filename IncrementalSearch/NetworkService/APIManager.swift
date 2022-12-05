//
//  APIManager.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 2/12/22.
//

import Foundation
import Combine


protocol APIRequestType {
    associatedtype Response: Decodable
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

class APIManager {
    
    private let baseURL: URL
    init(baseURL: URL = URL(string: "https://api.github.com")!) {
        self.baseURL = baseURL
    }

    func fetchGitRepoSerch(from request: SearchRequest) async throws -> [Repository] {
        let pathURL = URL(string: request.path, relativeTo: baseURL)!
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(SearchResultResponse.self, from: data)
        return response.items ?? []
       }
}
