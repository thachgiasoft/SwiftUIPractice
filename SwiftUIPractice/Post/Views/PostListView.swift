//
//  PostListView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/14.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    let category: PostListCategory

    @EnvironmentObject var userData: UserData
    
//    init() {
//        UITableView.appearance().separatorStyle = .none
//        UITableViewCell.appearance().selectionStyle = .none
//    }
    var body: some View {
        List {
//            ForEach(loadPostListData("PostListData_recommend_1.json").list, id: \.id)
            //Post实现了Identifiable协议，可以省略id: \.id
        ForEach(userData.postList(for: category).list) { post in
                ZStack {
                    PostCell(post: post)
                    NavigationLink(destination: PostDetailView(post: post)) {
                        EmptyView()
                    }
                    .hidden()
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostListView(category: .recommend)
            .environmentObject(UserData())
            .navigationBarTitle("Title")//必须设置title隐藏bar才起作用
            .navigationBarHidden(true)
        }
    }
}
