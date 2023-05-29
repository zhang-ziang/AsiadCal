//
//  ContentView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/23.
//

import SwiftUI

struct ContentView: View {
    @State var calendarTapped   : Bool = false
    @State var competitionTapped: Bool = false
    @State var userTapped       : Bool = false
    @State var showNvgbar       : Bool = true
    var body: some View {
        ZStack {
            NvgBar(showNvgbar: $showNvgbar, calendarTapped: $calendarTapped, competitionTapped: $competitionTapped, userTapped: $userTapped)
                .zIndex(10.0)
            CalendarView(showDetail: $calendarTapped)
                .zIndex(0.0)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
    }
}
