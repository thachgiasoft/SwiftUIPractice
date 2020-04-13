//
//  CalculatorButtonRow.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/13.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct CalculatorButtonRow: View {
    let row:[CalculatorButtonItem]
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,size: item.size, backgroudColor: item.backgroundColor) {
                    print("click \(item.title)")
                }
            }
        }
    }
}

struct CalculatorButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonRow(row: [.digit(1),.digit(2),.digit(3),.op(.plus)])
    }
}
