//
//  SearchRequest.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 5/12/22.
//

import Foundation


struct SearchRequest: APIRequestType {
    typealias Response = SearchResultResponse
    
    var searchKey = ""
    var pageNumber = ""
    
    var path: String { return "/search/repositories" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: searchKey),
            .init(name: "page", value: pageNumber),
            .init(name: "order", value: "desc")
        ]
    }
}
