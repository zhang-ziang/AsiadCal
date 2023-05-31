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
    @State var isAnimated: Bool = true
    @State private var showInsert = false
    @State private var circleAni  = false
    @State private var showMatchs = false
    @State var randomOffset:[offsetXY] = regenOffset()
    var body: some View {
        if curView == .atRecommendView{
            ZStack{
                AnimatedImage(name: "giphy.gif", bundle: Bundle.main, isAnimating: $isAnimated)
                    .playbackMode(.bounce)
                    .ignoresSafeArea()
                    .frame(width: .infinity, height: .infinity)
                    .opacity(0.8)
//                    .clipShape(
//                        RoundedRectangle(cornerRadius: 30)
//                    )
//                    .offset(y: 350)
                    .zIndex(0.01)
                    .onAppear{
                        isAnimated = true
                    }
                ForEach(0..<randomOffset.count, id: \.self) { value in
                    MatchCapsuleView(showInsert: $showInsert,mode:.recommend, match: matchesData.matches[value])
                        .zIndex(0.01*Double(value)+0.1)
                        .frame(width:100, height:100)
                        .opacity(showMatchs ? 0.9:0.0)
                        .scaleEffect(showMatchs ? CGFloat(Float.random(in: 0.8...1.0)) : 0.3)
                        .animation(.inOrderEasyInOut(Double(value)), value: showMatchs)
                        .offset(x:CGFloat(randomOffset[value].x), y:CGFloat(randomOffset[value].y))
                    //                    .offset(x:0, y:0)
                }
                CircleView(circleAni: $circleAni, circleShow: $showInsert)
                    .zIndex(4.0)
                    .opacity(showInsert ? 1.0:0.3)
                    .scaleEffect(showInsert ? 1.0 : 0.0)
                    .scaleEffect(circleAni ? 1.0 : 0.75)
                    .offset(x: showInsert ? 220:300,y:showInsert ? 300:450)
            }.onAppear(){
                //            randomOffset = regenOffset()
                withAnimation{
                    showMatchs = true
                }
            }
        }
    }
    
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
    static var previews: some View {
        recommendView(curView: $curView)
            .environmentObject(matchesData)
    }
}
