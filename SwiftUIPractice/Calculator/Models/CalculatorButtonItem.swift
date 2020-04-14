//
//  CalculatorButtonItem.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/13.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation
import SwiftUI

enum CalculatorButtonItem {
    
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "/"
        case multiply = "*"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem{
    var title: String{
        switch self {
        case .digit(let value):
            return String(value)
        case .dot:
            return "."
        case .op(let op):
            return op.rawValue
        case .command(let command):
            return command.rawValue
        }
    }
    
    var size: CGSize{
        if case .digit(let value) = self, value == 0 {
            return CGSize(width: 88 * 2 + 8, height: 88)
        }
        return CGSize(width: 88, height: 88)
    }
    
    
    var backgroundColor: UIColor {
        switch self {
        case .digit,.dot:
            return R.color.digitBackground()!
        case .op:
            return R.color.operatorBackground()!
        case .command:
            return R.color.commandBackground()!
        }
    }
    
}

extension CalculatorButtonItem: Hashable{}

extension CalculatorButtonItem: CustomStringConvertible{
    var description: String {
        switch self {
        case .digit(let num): return String(num)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }
}
