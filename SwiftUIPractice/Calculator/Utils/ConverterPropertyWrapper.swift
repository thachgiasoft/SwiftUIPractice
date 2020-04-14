//
//  ConverterPropertyWrapper.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/14.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation

@propertyWrapper
struct Converter {
    let from: String
    let to: String
    let rate: Double
    
    var value: Double
    
    var wrappedValue: String {
        get{
            "\(from)\(value)"
        }
        set{
            value = Double(newValue) ?? -1
        }
    }
    
    var projectedValue: String {
        return "\(to)\(value*rate)"
    }
    
    init(initialValue: String, from: String, to: String, rate: Double) {
        self.rate = rate
        self.value = 0
        self.from = from
        self.to = to
        self.wrappedValue = initialValue
    }
}
