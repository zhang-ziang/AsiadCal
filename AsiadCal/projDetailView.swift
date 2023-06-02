//
//  projDetailView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI

struct projDetailView: View {
//    var matches: [Match]
    @EnvironmentObject var matchesData : MatchesData
    var projType: SportType
//    var projTitle: String
    @Binding var showInsert: Bool
    @State var showMatchs: Bool = false
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var filteredMatches: [Match] {
        matchesData.matches.filter { match in
            (match.projTag == projType)
        }
    }
    var body: some View {
        VStack{
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
                    Text(projType.toString())
                        .font(.title)
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(0..<filteredMatches.count, id: \.self) { value in
                            MatchCapsuleView(showInsert: $showInsert, mode:.inlist,match: filteredMatches[value])
                                .frame(width:100, height:100)
                                .opacity(showMatchs ? 1.0:0.0)
                                .scaleEffect(showMatchs ? 0.9 : 0.3)
                                .animation(.inOrderEasyInOut(Double(value)), value: showMatchs)
                        }
                    }
                    .frame(width: 320)
                    Spacer()
                }
                .frame(width: 350, height: 540)
            }
        }
    }
}

struct projDetailView_Previews: PreviewProvider {
    @State static var matchesData = MatchesData()
    @State static var showInsert: Bool = false
    @State static var matches = loadMatches(filename: "matchesData")
    static var previews: some View {
        VStack{
            projDetailView(projType: .Football, showInsert: $showInsert)
                .environmentObject(matchesData)
        }
    }
}
