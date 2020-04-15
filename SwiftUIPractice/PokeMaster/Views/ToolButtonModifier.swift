//
//  ToolButtonModifier.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/15.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation
import SwiftUI

struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.system(size: 25))
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
    }
}
