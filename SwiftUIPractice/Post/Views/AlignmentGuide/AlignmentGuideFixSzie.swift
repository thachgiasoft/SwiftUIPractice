//
//  AlignmentGuideFixSzie.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/23.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct AlignmentGuideFixedSize: View {
    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text("Username")
                Text("Email")
                Text("Phone")
            }
            .font(.system(size: 35, weight: .bold))
            
            VStack(alignment: .leading) {
                Text("zhuli").frame(maxHeight: .infinity)
                Text("zhuli1228@163.com").frame(maxHeight: .infinity)
                Text("15620418888").frame(maxHeight: .infinity)
            }
            .font(.system(size: 25))
        }
        .fixedSize()
    }
}

struct AlignmentGuideFixSzie_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuideFixedSize()
    }
}
