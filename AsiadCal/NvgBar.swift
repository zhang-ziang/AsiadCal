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
    
    var tap2ExitAddEvent : some Gesture {
        TapGesture(count: 1)
            .onEnded {
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
            
            if curView == .atIdleView || curView == .atRecommendView {
                ZStack{
                    if(addEvent) {
                        Rectangle()
                            .foregroundColor(.white)
                            .blendMode(.multiply)
                            .gesture(tap2ExitAddEvent)
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 200)
                                .foregroundColor(.white)
                                .blendMode(.multiply)
                            // TODO : Add User event view placed here plz
                            // AddEventView ...
                        }
                        .zIndex(1919.0)
                    }
                    Button{
                        withAnimation{
                            addEvent = true
                        }
                    } label: {
                        Label{
                            
                        } icon: {
                            
                            ZStack{
                                
                                AnimatedImage(name: "giphy.gif", bundle: Bundle.main, isAnimating: $isAnimated)
                                    .playbackMode(.bounce)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: addEvent ? 350 : 60, height: addEvent ? 200 : 60)
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
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1145.0)
                
                
                if curView == .atIdleView{
                    recentEventView()
                    //                    .zIndex(0.0)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                ZStack{
                    
                    AnimatedImage(name: "giphy.gif", bundle: Bundle.main, isAnimating: $isAnimated)
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
                                curView = .atCalendarView
                                isAnimated = false
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
                                curView = .atRecommendView
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
                                //                                userTapped = true
                                //                                showText.toggle()
                                //                                showNvgbar = false
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
                    }
                    .frame(width: 250)
                    .zIndex(118.0)
                    .offset(x: 0, y: 345)
                    
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
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
            NvgBar(curView: .constant(.atIdleView))
            //            NvgBar()
        }
    }
}
