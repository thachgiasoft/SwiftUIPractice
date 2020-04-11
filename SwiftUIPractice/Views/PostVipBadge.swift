//
//  PostVipBadge.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/11.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PostVipBadge: View {
    var body: some View {
        Text("v")
            .bold()
            .font(.system(size: 11))
            .frame(width: 15, height: 15)
            .foregroundColor(.yellow)
            .background(Color.red)
            .clipShape(Circle())
            .overlay(
                RoundedRectangle(cornerRadius: 7.5)
                    .stroke(Color.white, lineWidth: 1)
        )
    }
}

struct PostVipBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVipBadge()
    }
}
