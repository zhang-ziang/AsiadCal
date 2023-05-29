//
//  ProjListView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI
import Foundation

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
//            insertion: .move(edge: .leading),
            insertion: .scale.combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

extension Animation{
    static func inOrderEasyInOut(_ delay:Double)-> Animation{
        return .easeInOut(duration: 0.3).delay(Double(delay) * 0.05)
    }
    static func randomEasyInOut()-> Animation{
        
        return .easeInOut(duration: 0.3).delay(Double.random(in: 0.0...30.0) * 0.02)
    }
}

struct ProjListView: View {
    @EnvironmentObject var projdatalist : ProjDataList
    @State private var showDetail = false
    @State private var showInsert = false
    @State private var circleAni  = false
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
//    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack{
            VStack(spacing: 50){
                Button("Press to show details") {
                    withAnimation {
                        showDetail.toggle()
                    }
                }
                
                Button("Press to show insert") {
                    withAnimation {
                        showInsert.toggle()
                    }
                }
                
                Button("Press to show circleAni") {
                    withAnimation {
                        circleAni.toggle()
                    }
                }
                
                LazyVGrid(columns: columns,spacing:40){
                    ForEach(0...11, id: \.self) { value in
                        ProjView(name: projdatalist.projDatas[value].name,urlString: projdatalist.projDatas[value].gifurl)
                        //                    RoundedRectangle(cornerRadius: 20)
                        //                        .fill(Color(hue: Double.random(in: 0.4...0.6), saturation: 0.25, brightness: 0.98))
                            .frame(width:100, height:100)
                            .opacity(showDetail ? 1.0:0.0)
                        //                    .transition(.opacity)
                        //                    .transition(.moveAndFade)
                        //                    .transition(.move(edge: .leading))
                        //                    .rotationEffect(.degrees(showDetail ? 90 : 0))
                            .scaleEffect(showDetail ? 1.0 : 0.3)
                        //                        .animation(.easeInOut(duration: 0.3).delay(Double(value) * 0.05), value: showDetail)
                        //                        .animation(.inOrderEasyInOut(Double(value)), value: showDetail)
                            .animation(.randomEasyInOut(), value: showDetail)
                    }
                }
                .frame(width:360, height:500)
                .onAppear{
                    showDetail = true
                }
                
            }
                    CircleView(circleAni: $circleAni)
                        .opacity(showInsert ? 1.0:0.3)
                        .scaleEffect(showInsert ? 1.0 : 0.0)
                        .offset(x: 220,y:225)
        }
    }
}

struct ProjListView_Previews: PreviewProvider {
    static var previews: some View {
//        VStack{
            ProjListView()
            .environmentObject(ProjDataList.sampleData())
//        }
    }
}

