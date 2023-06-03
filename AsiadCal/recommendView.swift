//
//  recommendView.swift
//  
//
//  Created by viglong on 2023/5/30.
//

import SwiftUI
import SDWebImageSwiftUI

struct offsetXY{
    var x: Float
    var y: Float
}
struct recommendView: View {
    @EnvironmentObject var matchesData : MatchesData
    @Binding var curView : NvgState
    @Binding var showInsert: Bool
    @Binding var circleAni: Bool
    @State var isAnimated: Bool = true
    @State private var showMatchs = false
    @State var randomOffset:[offsetXY] = regenOffset()
    
//    @State var randomMatch:[Int] = [0,1,2,3,4,5]
    
    @State var randomMatch:[Int] = regenMatch(matchCount: 10)
    @Binding var GlobeBackGroundName: String
    var body: some View {
        if curView == .atRecommendView{
            ZStack{
                AnimatedImage(name: GlobeBackGroundName, bundle: Bundle.main, isAnimating: $isAnimated)
                    .playbackMode(.bounce)
                    .ignoresSafeArea()
                    .frame(width: .infinity, height: .infinity)
                    .opacity(0.5)
//                    .clipShape(
//                        RoundedRectangle(cornerRadius: 30)
//                    )
//                    .offset(y: 350)
                    .zIndex(0.01)
                    .onAppear{
                        isAnimated = true
                    }
                ForEach(0..<randomOffset.count, id: \.self) { value in
                    MatchCapsuleView(showInsert: $showInsert,mode:.recommend, match: matchesData.matches[randomMatch[value]])
                        .zIndex(0.01*Double(value)+0.1)
                        .frame(width:100, height:100)
                        .opacity(showMatchs ? 0.9:0.0)
                        .scaleEffect(showMatchs ? CGFloat(Float.random(in: 0.8...1.0)) : 0.3)
                        .animation(.inOrderEasyInOut(Double(value)), value: showMatchs)
                        .offset(x:CGFloat(randomOffset[value].x), y:CGFloat(randomOffset[value].y))
                    //                    .offset(x:0, y:0)
                }
                
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
            .gesture(
                DragGesture()
                .onEnded {
                    if $0.translation.width < -100{
                        withAnimation{
                            curView = .atIdleView
                        }
                    }
                }
            )
            .onAppear(){
                randomOffset = regenOffset()
                randomMatch = regenMatch(matchCount: matchesData.matches.count)
                withAnimation{
                    showMatchs = false
                }
                withAnimation{
                    showMatchs = true
                }
            }
            .onDisappear(){
                withAnimation{
                    showMatchs = false
                }
            }
            .onDrop(of: [MatchCapsuleTypeIdentifier], delegate: WastedDropDelegate(circleAni: $circleAni, circleShow: $showInsert))
        }
    }
}

func regenMatch(matchCount:Int) -> [Int]{
    var ids:[Int] = []
    for i in 0..<matchCount{
        ids.append(i)
    }
    var ranids: [Int] = []
    for _ in 0...5 {
        let id = Int.random(in: 0..<ids.count)
        
        ranids.append(ids[id])
        ids.remove(at: id)
    }
    return ranids
}

func regenOffset() -> [offsetXY]{
    var offs:[offsetXY] = []
    for i in 0...5 {
        var offxy = offsetXY(x: Float.random(in: -130...130),y: Float.random(in: -250...250))
        while true{
            var brk = true
            for j in 0..<i{
                if abs(offs[j].x - offxy.x)<160 && abs(offs[j].y - offxy.y)<92 {
                    brk = false
                }
            }
            if brk{
                break
            }
            else{
                offxy = offsetXY(x: Float.random(in: -128...128),y: Float.random(in: -280...220))
            }
        }
        offs.append(offxy)
    }
    return offs
}



struct recommendView_Previews: PreviewProvider {
    @State static var matchesData = MatchesData()
    @State static var curView: NvgState = .atRecommendView
    
    @State static var showInsert = false
    @State static var circleAni  = false
    static var previews: some View {
        recommendView(curView: $curView, showInsert: $showInsert, circleAni: $circleAni, GlobeBackGroundName: .constant("purple.gif"))
            .environmentObject(matchesData)
    }
}
