//
//  AnimationTest.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/23.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct CustomHorizontalCenter: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[HorizontalAlignment.center]
    }
}

extension HorizontalAlignment{
    static let customCenter = HorizontalAlignment(CustomHorizontalAlignment.self)
}

struct AnimationTest: View {
    let categories = ["推荐","热门","学习","iOS","Android"]
    
    @State
    private var selectIndex = 0
    
    var body: some View {
        VStack(alignment: .customLeading) {
            HStack {
                ForEach(categories.indices, id: \.self) { index in
                    Text(self.categories[index])
                        .alignmentHorizontally(index == self.selectIndex)
                        .foregroundColor(index == self.selectIndex ? .orange : .black)
                        .onTapGesture {
                            withAnimation {
                                self.selectIndex = index
                            }
                    }
                }
                
            }
            RoundedRectangle(cornerRadius: 3)
            .frame(width: 20, height: 4)
                .foregroundColor(.orange)
                .alignmentGuide(.customLeading) {$0[HorizontalAlignment.center]}
        }
    }
}

extension View{
    func alignmentHorizontally(_ align: Bool) -> some View {
        if align {
            return AnyView(self.alignmentGuide(.customCenter) {$0[HorizontalAlignment.center]})
        }
        return AnyView(self)
    }
}

struct AnimationTest_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTest()
    }
}
