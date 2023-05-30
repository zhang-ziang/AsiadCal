//
//  ContentView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/23.
//

import SwiftUI

enum NvgState {
    case atCalendarView
    case atCompetitionView
    case atUserSettingView
    case atIdleView
}

struct ContentView: View {
    @State var curView: NvgState = .atIdleView
    var body: some View {
        ZStack {
        
            NvgBar(curView: $curView)
                .zIndex(10.0)
            CalendarView(curView: $curView)
                .zIndex(1.0)
        }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
    }
}
