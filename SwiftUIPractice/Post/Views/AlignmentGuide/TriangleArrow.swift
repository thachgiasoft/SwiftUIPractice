//
//  TriangleArrow.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/23.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct TriangleArrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { (path) in
            path.move(to: .zero)
            path.addArc(
                center: CGPoint(x: -rect.width / 5, y: rect.height / 2), radius: rect.width / 2,
                    startAngle: .degrees(-45),
                    endAngle: .degrees(45),
                    clockwise: false
                )
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
            path.closeSubpath()
        }
    }
}
