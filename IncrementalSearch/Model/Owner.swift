//
//  Owner.swift
//  IncrementalSearch
//
//  Created by Amit Chowdhury on 2/12/22.
//

import Foundation

struct Owner: Codable {
    let id: Int
    let ownerName: String
    let profilePhotoUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case ownerName = "login"
        case profilePhotoUrl = "avatar_url"
    }
}
