//
//  projDetailView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI

struct projDetailView: View {
    var matches: [Match]
    var projTitle: String
    @Binding var showInsert: Bool
    @State var showMatchs: Bool = false
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack{
//            Button("Press to show circleAni") {
//                withAnimation {
//                    showMatchs.toggle()
//                }
//            }
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 350, height: 600)
                    .foregroundColor(.white)
                    .shadow(radius: 60)
                    .onAppear(){
                        withAnimation{
                            showMatchs = true
                        }  
                    }
                    .onDisappear(){
                        withAnimation{
                            showMatchs = false
                        }
                    }
                VStack{
                    Text(projTitle)
                        .font(.title)
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(0...7, id: \.self) { value in
                            MatchCapsuleView(showInsert: $showInsert, mode:.inlist,match: matches[value])
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
    @State static var showInsert: Bool = false
    @State static var matches = loadMatches(filename: "matchesData")
    static var previews: some View {
        VStack{
            projDetailView(matches: matches, projTitle: "足球", showInsert: $showInsert)
        }
    }
}
