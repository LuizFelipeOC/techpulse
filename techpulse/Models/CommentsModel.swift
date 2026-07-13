//
//  CommentsModel.swift
//  techpulse
//
//  Created by Luiz Felipe on 08/07/26.
//

import Foundation

struct CommentsModel: Decodable {
    let id: String
    let body: String?
    let createdAt: String
    let ownerUsername: String
    let children: [CommentsModel]
    
    var depth: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case body
        case createdAt = "createdAt"
        case ownerUsername = "ownerUsername"
        case children
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.ownerUsername = try container.decodeIfPresent(String.self, forKey: .ownerUsername) ?? "removido"
        self.children = try container.decodeIfPresent([CommentsModel].self, forKey: .children) ?? []
        self.depth = 0
    }
}
