//
//  SwiftUIView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/13.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
//    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("0111")
                .font(.system(size: 76 * scale))
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
            CalculatorButtonPad().padding(.bottom)
        }
//        .scaleEffect(scale)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUIView()
            SwiftUIView().previewDevice("iPhone SE").environment(\.colorScheme, .dark)
            SwiftUIView().previewDevice("iPad Air 2")
        }
    }
}
