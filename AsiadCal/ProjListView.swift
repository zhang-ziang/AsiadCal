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
            insertion: .scale.combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

extension Animation{
    static func inOrderEasyInOut(_ delay:Double)-> Animation{
        return .easeInOut(duration: 0.3).delay(0.4+Double(delay) * 0.1)
    }
    static func randomEasyInOut()-> Animation{
        
        return .easeInOut(duration: 0.3).delay(Double.random(in: 0.0...30.0) * 0.02)
    }
}

struct ProjListView: View {
//    @EnvironmentObject var projdatalist : ProjDataList
    @EnvironmentObject var matchesData : MatchesData
    @Binding var showInsert: Bool
    @Binding var circleAni : Bool
    @State private var showProj = false
    @State private var gifAni     = false
    @State private var showDetail = false
    @State private var matchDetail = false
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    //    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 30){
//                Button("Press to show projects") {
//                    withAnimation {
//                        showProj.toggle()
//                    }
//                }
//                Button("Press to show insert") {
//                    withAnimation {
//                        showInsert.toggle()
//                    }
//                }
//                Button("Press to show circleAni") {
//                    withAnimation {
//                        circleAni.toggle()
//                    }
//                }
                Text("所有比赛")
                    .font(.system(size : 40))
                    .bold()
                    .frame(height:60)
                
                LazyVGrid(columns: columns,spacing:40){
                    ForEach(0...11, id: \.self) { value in
                        ProjView(name: SportType(ID: value).toString(), isAnimating: $gifAni)
                            .frame(width:100, height:100)
                            .opacity(showProj ? 1.0:0.0)
                            .scaleEffect(showProj ? 1.0 : 0.3)
                        //                        .animation(.easeInOut(duration: 0.3).delay(Double(value) * 0.05), value: showDetail)
                        //                        .animation(.inOrderEasyInOut(Double(value)), value: showDetail)
                            .animation(.randomEasyInOut(), value: showProj)
                            .onTapGesture {
                                withAnimation{
                                    showDetail.toggle()
                                }
                            }
                    }
                }
                .zIndex(2.0)
                .frame(width:360, height:500)
                .onAppear{
                    showProj = true
                }
                Spacer()
            }
            if(showDetail){
                projDetailView(matches: matchesData.matches, projTitle: "足球",showInsert: $showInsert ,showMatchs: false)
                    .zIndex(3.0)
                    .transition(.move(edge: .bottom))
                    .onTapGesture {
                        withAnimation{
                            showDetail.toggle()
                            matchDetail.toggle()
                        }
                    }
            }
            
        }
        .onDrop(of: [MatchCapsuleTypeIdentifier], delegate: WastedDropDelegate(circleAni: $circleAni, circleShow: $showInsert))
    }
}
struct WastedDropDelegate : DropDelegate {
    
//    let todoStatus: TodoStatus
//    let todoList: TodoList
    @Binding var circleAni: Bool
    @Binding var circleShow: Bool
    
    func validateDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - validateDrop() called")
        return true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - performDrop() called")
        withAnimation{
            circleAni = false
            circleShow = false
        }
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print("AddDropDelegate - dropEntered() called")
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("AddDropDelegate - dropUpdated() called")
        return DropProposal(operation: .move)
    }
    
    func dropExited(info: DropInfo) {
        print("AddDropDelegate - dropExited() called")
//        withAnimation{
//            circleAni = false
//            circleShow = false
//        }
    }
    
}
struct ProjListView_Previews: PreviewProvider {
    @State static var matchesData = MatchesData()
    
    @State static var showInsert = false
    @State static var circleAni  = false
    static var previews: some View {
        VStack{
            ProjListView(showInsert: $showInsert, circleAni: $circleAni)
//                .environmentObject(ProjDataList.sampleData())
                .environmentObject(matchesData)
        }
    }
}

