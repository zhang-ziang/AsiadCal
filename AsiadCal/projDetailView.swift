//
//  projDetailView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI

struct projDetailView: View {
    var projTitle: String
    @State var showMatchs: Bool
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack{
            Button("Press to show circleAni") {
                withAnimation {
                    showMatchs.toggle()
                }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 350, height: 600)
                    .foregroundColor(.white)
        //            .offset(x: 0, y: 300)
                    .shadow(radius: 60)
                VStack{
                    Text("")
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(0...7, id: \.self) { value in
                            MatchCapsuleView(matchTime: "9月26日14:00-17:00", matchLocation: "6号羽毛球馆",matchDetail: "林丹-李宗伟")
                                .frame(width:100, height:100)
                                .opacity(showMatchs ? 1.0:0.0)
                                .scaleEffect(showMatchs ? 0.9 : 0.3)
                                .animation(.inOrderEasyInOut(Double(value)), value: showMatchs)
                        }
                    }
                    .frame(width: 320)
                }
            }
        }
    }
}

struct projDetailView_Previews: PreviewProvider {
    @State static var showMatchs: Bool = true
    static var previews: some View {
        VStack{
            projDetailView(projTitle: "羽毛球", showMatchs: showMatchs)
        }
    }
}
