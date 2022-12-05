//
//  ResponseModel.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 5/12/22.
//

import Foundation

struct SearchResultResponse: Codable {
    
    var totalCount: Int?
    
    var items: [Repository]?
        
    var errorMessage: String?
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
        case errorMessage = "message"
    }
}
