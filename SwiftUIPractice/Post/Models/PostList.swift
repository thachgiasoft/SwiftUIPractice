//
//  PostList.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/14.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation

struct PostList : Codable {

    let list : [Post]

    enum CodingKeys: String, CodingKey {
            case list = "list"
    }

    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([Post].self, forKey: .list) ?? []
    }

}
