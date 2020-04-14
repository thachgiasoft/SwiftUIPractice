//
//  Post.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/13.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation
import SwiftUI

struct Post : Codable, Identifiable {

    let id : Int
    let avatar : String
    let vip : Bool
    let name : String
    let date : String
    let isFollowed : Bool
    let text : String
    let images : [String]
    let commentCount : Int
    let likeCount : Int
    let isLiked : Bool

    enum CodingKeys: String, CodingKey {
            case id = "id"
            case avatar = "avatar"
            case vip = "vip"
            case name = "name"
            case date = "date"
            case isFollowed = "isFollowed"
            case text = "text"
            case images = "images"
            case commentCount = "commentCount"
            case likeCount = "likeCount"
            case isLiked = "isLiked"
    }

    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
            avatar = try values.decodeIfPresent(String.self, forKey: .avatar) ?? ""
            vip = try values.decodeIfPresent(Bool.self, forKey: .vip) ?? false
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
            date = try values.decodeIfPresent(String.self, forKey: .date) ?? ""
            isFollowed = try values.decodeIfPresent(Bool.self, forKey: .isFollowed) ?? false
            text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
            images = try values.decodeIfPresent([String].self, forKey: .images) ?? []
            commentCount = try values.decodeIfPresent(Int.self, forKey: .commentCount) ?? 0
            likeCount = try values.decodeIfPresent(Int.self, forKey: .likeCount) ?? 0
            isLiked = try values.decodeIfPresent(Bool.self, forKey: .isLiked) ?? false
    }

}

extension Post{
    var avatarImage: Image {
        return loadImage(name: avatar)
    }
    
    var commentCountText: String {
        if commentCount <= 0 { return "评论" }
        if commentCount < 1000 { return "\(commentCount)" }
        return String(format: "%.1fK", Double(commentCount) / 1000)
    }
    
    var likeCountText: String {
        if likeCount <= 0 { return "点赞" }
        if likeCount < 1000 { return "\(likeCount)" }
        return String(format: "%.1fK", Double(likeCount) / 1000)
    }
}

func loadImage(name: String) -> Image {
    return Image(uiImage: UIImage(named: name)!)
}
