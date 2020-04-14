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
    
//    @ObservedObject
//    var model: CalculatorModel
    
    @EnvironmentObject
    var model: CalculatorModel
    
    @State
    private var editingHistory = false
    
    @State
    private var showResult = false
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Button("操作履历： \(model.history.count)") {
                print(self.model.history)
                self.editingHistory = true
            }.sheet(isPresented: $editingHistory) {
                HistoryView(model: self.model)
            }
                        
            Text(model.brain.output)
                .font(.system(size: 76 * scale))
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .onTapGesture {
                    print("onTapGesture")
                    self.showResult = true
                }.alert(isPresented: self.$showResult) {
//                    Alert(title: Text(self.model.hsitoryDetail), message: Text(self.model.brain.output), dismissButton: .default(Text("OK")))
                    Alert(title: Text(self.model.hsitoryDetail), message: Text(self.model.brain.output), primaryButton: .default(Text("复制"), action: {
                        print("复制")
                    }), secondaryButton: .default(Text("取消")))

                }
            
            Button(action: {
                self.model.brain = .left("1.23")
            }) {
                Text("Test")
            }
//            CalculatorButtonPad(brain:$model.brain).padding(.bottom)
//            CalculatorButtonPad(model:model).padding(.bottom)
            CalculatorButtonPad().padding(.bottom)
        }
//        .scaleEffect(scale)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorView()
            CalculatorView().previewDevice("iPhone SE").environment(\.colorScheme, .dark)
            CalculatorView().previewDevice("iPad Air 2")
        }
    }
}
