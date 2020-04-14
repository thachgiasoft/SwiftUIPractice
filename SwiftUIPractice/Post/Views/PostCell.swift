//
//  PostCell.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/11.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    let post: Post
    
    var body: some View {
        HStack(spacing: 5) {
            post.avatarImage
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    PostVipBadge(vip: true)
                        .offset(x: 16, y: 16)
            )
            
            VStack(alignment: .leading) {
                Text(post.name)
                    .font(.system(size: 16))
                    .foregroundColor(.red)
                    .lineLimit(1)
                Text(post.date)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
            .padding(.leading,10)
            
            if !post.isFollowed {
                Spacer()
                
                Button(action: {
                    print("click follow button")
                }) {
                    Text("关注")
                        .font(.system(size: 14))
                        .foregroundColor(.orange)
                    .frame(width: 50, height: 26)//增大点击区域及圆角
                    .overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                }
            }
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: loadPostListData("PostListData_recommend_1.json").list[1])
    }
}