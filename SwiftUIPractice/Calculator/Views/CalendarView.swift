//
//  CalendarView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/15.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.calendar)
    var calendar: Calendar
    
    @Environment(\.locale)
    var locle: Locale
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Text(locle.identifier)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
