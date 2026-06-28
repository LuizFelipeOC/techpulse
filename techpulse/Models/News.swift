//
//  News.swift
//  techpulse
//
//  Created by Luiz Felipe on 28/06/26.
//

import Foundation

struct News : Codable, Hashable {
    var id: String
    var ownerId: String
    var slug: String
    var title: String
    var body: String
    var createdAt: Date
    var updatedAt: Date
    var tabCoins: Int
    var ownerUsername: String
    var childrenDeepCount: Int
}

