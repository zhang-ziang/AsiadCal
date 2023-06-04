//
//  NvgBar.swift
//  AsiadCal
//
//  Created by ChenSir on 2023/5/29.
//

import SwiftUI
import SDWebImageSwiftUI

struct NvgBar: View {
    
    @State var isAnimated: Bool = false
    @State var showText:   Bool = true
    @State var addEvent:   Bool = false
    @Binding var curView : NvgState
    @Binding var GlobeBackGroundName : String
    
    @State var InputDate: Date = Date.now
    @State var InputTitle: String = ""
    @State var InputLocation: String = ""
    @State var refreshList: Bool = false
    var tap2ExitAddEvent : some Gesture {
        TapGesture(count: 1)
            .onEnded {
                InputDate = Date.now
                InputTitle = ""
                InputLocation = ""
                withAnimation{
                    addEvent = false
                }
            }
    }
    
    var body: some View {
        ZStack{
            //            // used fo debug
            //            if showText {
            //                Text("hello~")
            //            }
            
            if curView == .atIdleView || curView == .atRecommendView || curView == .atCompetitionView || curView == .atUserSettingView {
                ZStack{
                    if(addEvent) {
                        Rectangle()
                            .foregroundColor(.white)
                            .blendMode(.multiply)
                            .gesture(tap2ExitAddEvent)
                        
                        ZStack{
                            
                            //                                .blendMode(.multiply)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 300)
                                .foregroundColor(.white)
                                .blendMode(.multiply)
                            // TODO : Add User event view placed here plz
                            // AddEventView ...
                            VStack(spacing: 20){
                                HStack(spacing: 20){
                                    Text("事件")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    TextEditor(text: $InputTitle)
                                        .frame(width: 200, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .opacity(0.8)
                                }
                                HStack(spacing: 20){
                                    Text("时间")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
//                                    TextEditor(text: $InputDate)
//                                        .frame(width: 200, height: 40)
//                                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                                        .opacity(0.8)
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 200, height: 40)
                                            .opacity(0.8)
                                            .foregroundColor(.white)
                                        DatePicker("",selection: $InputDate)
                                            .frame(width: 200, height: 40)
    //                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                            
                                    }
                                }
                                HStack(spacing: 20){
                                    Text("地点")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    TextEditor(text: $InputLocation)
                                        .frame(width: 200, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .opacity(0.8)
                                }
                                Button {
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.dateFormat = "yyyy/MM/dd"
//                                    dateFormatter.timeZone = TimeZone.current
//                                    dateFormatter.locale = Locale.current
//                                    let matchdate = dateFormatter.date(from: InputDate)!
                                    
                                    if !RecommandTravelMethod.contains(where: {$0.key == InputLocation}){
                                        RecommandTravelMethod[InputLocation] = [TravelMtd("figure.walk"), TravelMtd("car.fill")]
                                    }

                                    AddEvent(EventName: InputTitle, EventDate: InputDate, EventType: .None, EventPos: InputLocation)
                                    InputDate = Date.now
                                    InputTitle = ""
                                    InputLocation = ""
                                    refreshList.toggle()
                                    withAnimation{
                                        addEvent = false
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 100, height: 60)
                                        .foregroundColor(.white)
                                }

                            }.frame(width: 350, height: 300)
                            
                        }
                        .zIndex(1919.0)
                    }
                    if curView == .atIdleView{
                        Button{
                            withAnimation{
                                addEvent = true
                            }
                        } label: {
                            Label{
                                
                            } icon: {
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: addEvent ? 10 : 30)
                                        .frame(width: addEvent ? 350 : 60, height: addEvent ? 300 : 60)
                                        .foregroundColor(.white)
                                    
                                    AnimatedImage(name: GlobeBackGroundName, bundle: Bundle.main, isAnimating: $isAnimated)
                                        .playbackMode(.bounce)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: addEvent ? 350 : 60, height: addEvent ? 300 : 60)
                                        .opacity(0.6)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: addEvent ? 10 : 30)
                                        )
                                    //                                    .colorInvert()
                                    //                                if(!addEvent) {
                                    Text("+")
                                        .font(.system(size: 50))
                                        .foregroundColor(.white)
                                        .opacity(addEvent ? 0.0 : 1.0)
                                    //                                }
                                }
                            }
                        }
                        .shadow(radius: 10)
                        .offset(x: addEvent ? 0 : 130, y: addEvent ? 0 : 250)
                        //                .frame(width: addEvent ? 350 : 70, height: addEvent ? 200 : 70)
                    }
                    
                    
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1145.0)
                
                
                if curView == .atIdleView{
                    recentEventView(refreshList: $refreshList)
                    //                    .zIndex(0.0)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                if (curView == .atIdleView || curView == .atRecommendView || curView == .atCompetitionView || curView == .atUserSettingView) {
                    ZStack{
                        
                        AnimatedImage(name: GlobeBackGroundName, bundle: Bundle.main, isAnimating: $isAnimated)
                            .playbackMode(.bounce)
                            .frame(width: 320, height: 60)
                            .opacity(0.6)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 30)
                            )
                            .offset(y: 350)
                            .zIndex(7.0)
                            .onAppear{
                                isAnimated = true
                            }
                        HStack {
                            Button {
                                withAnimation{
                                    if(curView != .atIdleView) {
                                        curView = .atIdleView
                                        isAnimated = true
                                    }
                                    else {
                                        curView = .atCalendarView
                                        isAnimated = false
                                    }
                                    
                                }
                            } label: {
                                Label{
                                    
                                } icon: {
                                    Image("calendarIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .offset(y: 10)
                                        .clipped()
                                        .colorInvert()
                                    
                                }
                            }
                            Spacer()
                            Button {
                                withAnimation{
                                    //                                competitionTapped = true
                                    //                                showText.toggle()
                                    //                                showNvgbar = false
                                    //                                curView = .atCompetitionView
                                    if(curView != .atCompetitionView) {
                                        curView = .atCompetitionView
                                    }
                                    else {
                                        curView = .atIdleView
                                    }
                                    
                                }
                            } label: {
                                Label{
                                    
                                } icon: {
                                    Image("AsiadIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 50)
                                        .offset(y: 7)
                                        .clipped()
                                        .colorInvert()
                                    //                                    .gesture(competitionTap)
                                }
                            }
                            
                            Spacer()
                            Button {
                                withAnimation{
                                    curView = .atUserSettingView
                                }
                            } label: {
                                Label{
                                    
                                } icon: {
                                    Image("userIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .offset(y: 10)
                                        .clipped()
                                        .colorInvert()
                                    //                                    .gesture(userTap)
                                }
                            }
                        } // bar end
                        .frame(width: 250)
                        .zIndex(118.0)
                        .offset(x: 0, y: 345)
                        
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
}

struct NvgBar_Previews: PreviewProvider {
    //    @State var calendarTapped   : Bool = false
    //    @State var competitionTapped: Bool = false
    //    @State var userTapped       : Bool = false
    
    static var previews: some View {
        VStack{
            NvgBar(curView: .constant(.atIdleView), GlobeBackGroundName: .constant("giphy.gif"))
            //            NvgBar()
        }
    }
}
