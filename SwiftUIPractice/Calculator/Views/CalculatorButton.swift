//
//  CalculatorButton.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/13.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

let scale = UIScreen.main.bounds.width / 414

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroudColor: UIColor
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize * scale))
                .foregroundColor(.white)
                .frame(width: size.width * scale, height: size.height * scale)
                //.padding()
                .background(Color(backgroudColor))
                .cornerRadius(size.width * scale / 2)//方式1
//                .clipShape(Circle())//方式2
            
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(title: "+",size: CGSize(width: 88 * scale, height: 88 * scale), backgroudColor: R.color.operatorBackground()!) {
            print("click +")
        }
    }
}
