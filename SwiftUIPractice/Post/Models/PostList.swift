//
//  PostList.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/14.
//  Copyright © 2020 lizhu. All rights reserved.
//

/**
 JSON数据处理：JSONDecoder
 1.  遵循Codable
 2.  如果遇到嵌套的情况则通过在struct里再套一个struct
 3.  对于有时不会返回的字段设置为optional类型
 4.  不同代码风格通过CodingKeys映射的方式实现对不同代码风格的兼容
 ```
 enum CodingKeys: String, CodingKey {
         case list = "list"
 }
 
 5. JSONDecoder的keyDecodingStategy属性：useDefaultKeys、convertFromSnakeCase、custom
 */

import Foundation

struct PostList : Codable {

   var list: [Post]

    enum CodingKeys: String, CodingKey {
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([Post].self, forKey: .list) ?? []
    }

}
