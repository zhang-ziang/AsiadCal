//
//  NvgBar.swift
//  AsiadCal
//
//  Created by ChenSir on 2023/5/29.
//

import SwiftUI
import SDWebImageSwiftUI

struct NvgBar: View {
    @State var isAnimated: Bool = true
    @State var showText:   Bool = true
    
    @Binding var showNvgbar       : Bool
    @Binding var calendarTapped   : Bool
    @Binding var competitionTapped: Bool
    @Binding var userTapped       : Bool
    
//    var calendarTap: some Gesture {
//        TapGesture(count: 1)
//            .onEnded {
//                withAnimation{
//                    calendarTapped = true
//                    showText.toggle()
//                }
//            }
//    }
//    var competitionTap: some Gesture {
//        TapGesture(count: 1)
//            .onEnded {
//                withAnimation{
//                    competitionTapped = true
//                    showText.toggle()
//                }
//            }
//    }
//    var userTap: some Gesture {
//        TapGesture(count: 1)
//            .onEnded {
//                withAnimation{
//                    userTapped = true
//                    showText.toggle()
//                }
//            }
//    }
    var body: some View {
        ZStack{
//            // used fo debug
//            if showText {
//                Text("hello~")
//            }
            if !userTapped && !calendarTapped && !competitionTapped {
                ZStack{
                    AnimatedImage(name: "giphy.gif", bundle: Bundle.main, isAnimating: $isAnimated)
                        .playbackMode(.reversedBounce)
                        .frame(width: 320, height: 60)
                        .opacity(0.6)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30)
                        )
                        .offset(y: 350)
                        .zIndex(7.0)
                    HStack {
                        Button {
                            withAnimation{
                                calendarTapped = true
//                                showText.toggle()
//                                showNvgbar = false
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
                    .zIndex(8.0)
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
            NvgBar(showNvgbar: .constant(true), calendarTapped: .constant(false), competitionTapped: .constant(false), userTapped: .constant(false))
//            NvgBar()
        }
    }
}
