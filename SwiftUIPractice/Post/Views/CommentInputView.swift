//
//  CommentInputView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/20.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct CommentInputView: View {
    let post: Post

    @Environment(\.presentationMode)
    var presentationMode
    
    @State
    private var text: String = ""
    @State
    private var showEmptyTextHUD: Bool = false

    @ObservedObject
    private var keyboardResponder = KeyboardResponder()
    
    @EnvironmentObject
    var userData: UserData
    
    var body: some View {
        VStack(spacing: 0) {
            CommentTextView(text: $text, beginEditingOnAppear: true)
            
            HStack(spacing: 0) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("取消")
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                        self.showEmptyTextHUD.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.showEmptyTextHUD.toggle()
                        }
                        return
                    }
                    var post = self.post
                    post.commentCount += 1
                    self.userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("发送")
                    .padding()
                }
            }
        }
        .overlay(
            Text("评论不能为空")
                .scaleEffect(showEmptyTextHUD ? 1 : 0.5)
                .animation(.spring(dampingFraction: 0.5))
                .opacity(showEmptyTextHUD ? 1 : 0)
                .animation(.easeInOut)
        )
        .font(.system(size: 18))
        .foregroundColor(.black)
        .padding(.bottom,keyboardResponder.keyboardHeight)
        .edgesIgnoringSafeArea(keyboardResponder.keyboardShow ? .bottom : [])
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(post: UserData().recommedPostList.list[0])
    }
}
