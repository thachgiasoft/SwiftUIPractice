//
//  SettingRootView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/21.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView{
            SettingView().navigationBarTitle("设置")
        }
    }
}

struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
