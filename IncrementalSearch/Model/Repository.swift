//
//  Repository.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 2/12/22.
//

import Foundation

struct Repository: Codable, Identifiable {
    
    let id: Int
    let name: String?
    let fullName: String?
    let repositroyUrl: String?
    let repositoryDescription: String?
    let programingLanguage: String?
    let owner: Owner?
    let numberOfStar: Int?
        
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case repositroyUrl = "html_url"
        case repositoryDescription = "description"
        case programingLanguage = "language"
        case owner
        case numberOfStar = "stargazers_count"
    }
}
