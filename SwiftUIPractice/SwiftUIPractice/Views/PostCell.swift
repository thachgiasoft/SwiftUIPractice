//
//  PostCell.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/11.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("用户昵称")
                    .font(.system(size: 16))
                    .foregroundColor(.red)
                    .lineLimit(1)
                Text("2020-04-11 13:50")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
            
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

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}
