//
//  PostListView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/14.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    var body: some View {
        List {
//            ForEach(loadPostListData("PostListData_recommend_1.json").list, id: \.id)
            //Post实现了Identifiable协议，可以省略id: \.id
            ForEach(loadPostListData("PostListData_recommend_1.json").list) { post in
                PostCell(post: post).listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
