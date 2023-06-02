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
    case atNone
}

struct ContentView: View {
    @State var curView: NvgState = .atIdleView
    
    @State var showInsert = false
    @State var circleAni  = false
    var body: some View {
        ZStack {
            CalendarView(curView: $curView)
//                .zIndex(0.0)
            
//                .zIndex(10.0)
            ProjListView(curView: $curView, showInsert: $showInsert, circleAni: $circleAni)
            recommendView(curView: $curView, showInsert: $showInsert, circleAni: $circleAni)
            
            NvgBar(curView: $curView)
//                .shadow(radius: 10)
//                .zIndex(100.0)
            CircleView(circleAni: $circleAni, circleShow: $showInsert)
                .zIndex(4.0)
                .opacity(showInsert ? 1.0:0.3)
                .scaleEffect(showInsert ? 1.0 : 0.0)
                .scaleEffect(circleAni ? 1.0 : 0.75)
                .offset(x: showInsert ? 220:300,y:showInsert ? 300:450)
        }
        .gesture(
            DragGesture()
            .onEnded {
                if $0.translation.width < -100 && curView == .atIdleView{
                    withAnimation{
                        curView = .atRecommendView
                    }
                }
            }
        )
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
