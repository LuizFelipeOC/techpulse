//
//  CommentsModel.swift
//  techpulse
//
//  Created by Luiz Felipe on 08/07/26.
//

import Foundation


struct CommentsModel: Codable, Hashable, Sendable {
    var id: String
    var body: String
    var createdAt: String
    var ownerUsername: String
    var childreen: [CommentsModel]?
}
