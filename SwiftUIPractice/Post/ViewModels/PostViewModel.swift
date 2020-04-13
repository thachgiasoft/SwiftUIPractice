//
//  PostViewModel.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/14.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation

func loadPostListData(_ fileName: String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not find \(fileName) in main bundle")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not load \(url)")
    }
    
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can not parse post list json data")
    }
    
    return list;
}
