//
//  APIServiceError.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 5/12/22.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
