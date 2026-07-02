//
//  News.swift
//  techpulse
//
//  Created by Luiz Felipe on 28/06/26.
//

import Foundation


struct News : Codable, Hashable, Sendable {
    var id: String
    var ownerId: String
    var slug: String
    var title: String
    var body: String?
    var createdAt: String
    var updatedAt: String
    var tabcoins: Int
    var ownerUsername: String
    var childrenDeepCount: Int
}

