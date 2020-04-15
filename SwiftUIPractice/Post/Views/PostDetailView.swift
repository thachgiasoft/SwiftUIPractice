//
//  PostDetailView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/15.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        List {
            PostCell(post: post)
                .listRowInsets(EdgeInsets())
            
            ForEach(1...10, id: \.self) { i in
                Text("评论\(i)")
            }
        }
        .navigationBarTitle("详情", displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: loadPostListData("PostListData_recommend_1.json").list[0])
    }
}
