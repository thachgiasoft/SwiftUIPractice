//
//  SwiftUIView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/13.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
//    let scale: CGFloat = UIScreen.main.bounds.width / 414
//    @State
//    private var brain: CalculatorBrain = .left("0")
    
    @ObservedObject
    var model: CalculatorModel
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(model.brain.output)
                .font(.system(size: 76 * scale))
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
            Button(action: {
                self.model.brain = .left("1.23")
            }) {
                Text("Test")
            }
            CalculatorButtonPad(brain:$model.brain).padding(.bottom)
        }
//        .scaleEffect(scale)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorView(model: CalculatorModel())
//            SwiftUIView().previewDevice("iPhone SE").environment(\.colorScheme, .dark)
//            SwiftUIView().previewDevice("iPad Air 2")
        }
    }
}
