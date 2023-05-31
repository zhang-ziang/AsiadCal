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
    case atRecommendView
    case atIdleView
}

struct ContentView: View {
    @State var curView: NvgState = .atIdleView
    var body: some View {
        ZStack {
            CalendarView(curView: $curView)
//                .zIndex(0.0)
            
//                .zIndex(10.0)
            recommendView(curView: $curView)
            
            NvgBar(curView: $curView)
                .shadow(radius: 10)
                .zIndex(100.0)
        }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var matchesData = MatchesData()
    static var previews: some View {
        ZStack{
            ContentView()
                .environmentObject(matchesData)
        }
    }
}
