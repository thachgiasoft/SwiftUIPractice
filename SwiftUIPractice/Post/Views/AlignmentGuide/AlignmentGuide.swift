//
//  AlignmentGuide.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/23.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

extension HorizontalAlignment{
    struct CustomHorizontalAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.leading]
        }
    }
    
    static let customLeading = HorizontalAlignment(CustomHorizontalAlignment.self)
}

struct AlignmentGuide: View {
    var body: some View {
        VStack(alignment: .customLeading) {
            HStack {
                Text("Username").titleStyle()
                Text("zhuli").contentStyle()
//                    .alignmentGuide(.leading) { (viewDimensions) -> CGFloat in
//                        viewDimensions[.leading]
//                }
                //添加alignmentGuide没有效果，Text的alignmentGuide参数与VStack的alignmentGuide参数相同，但中间隔着HStack系统自带的alignmentGuide，导致跨容器失效
                //跨容器对齐需要自定义Alignment
                //移动到扩展里
//                    .alignmentGuide(.customLeading) { $0[.leading] }
                //右侧文字左对齐，共享同一条基线
            }
            HStack {
                Text("Email").titleStyle()
                Text("zhuli1228@163.com").contentStyle()
                //移动到扩展里
//                .alignmentGuide(.customLeading) { $0[.leading] }
            }
            HStack {
                Text("Phone").titleStyle()
                Text("15620418888").contentStyle()
                //移动到扩展里
//                .alignmentGuide(.customLeading) { $0[.leading] }
            }
        }
    }
}

extension Text{
    func titleStyle() -> Self {
        self.font(.system(size: 35, weight: .bold))
    }
    
    func contentStyle() -> some View {
        self.font(.system(size: 25))
        .alignmentGuide(.customLeading) { $0[.leading] }
    }
}

struct AlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuide()
    }
}
