//
//  HomeView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/18.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State private var leftPercent: CGFloat = 0 // 0 for left, 1 for right
    @State private var switchHomeDartOrLight = true

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height), leftPercent: self.$leftPercent) {
                    HStack(spacing: 0) {
                        PostListView(category: .recommend)
                            .frame(width: geometry.size.width)
                        
                        PostListView(category: .hot)
                            .frame(width: geometry.size.width)
                    }
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent, swichHomeBlackOrLight: $switchHomeDartOrLight).saturation(self.switchHomeDartOrLight ? 1 : 0))
            .navigationBarTitle("首页", displayMode: .inline)
            .saturation(self.switchHomeDartOrLight ? 1 : 0)
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        .saturation(0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
         HomeView().environmentObject(UserData())
    }
}
