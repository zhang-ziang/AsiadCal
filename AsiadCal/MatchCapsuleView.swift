//
//  MatchCapsuleView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI

struct MatchCapsuleView: View {
//    var matchTitle: String
    var matchTime: String
    var matchLocation: String
    var matchDetail: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: Color(uiColor: .systemCyan),radius: 2)
                .frame(width: 172,height: 96)
            VStack{
                HStack(alignment:.center,spacing:2){
                    Rectangle()
                        .frame(width:30, height:20)
                        .foregroundColor(.red)
                    Text(matchDetail)
                        .frame(width:90, height:30)
                        .font(.system(size: 16))
                        .bold()
                    Rectangle()
                        .frame(width:30, height:20)
                        .foregroundColor(.blue)
                }
                
                Text(matchTime)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .font(.footnote)
                Text(matchLocation)
                    .font(.footnote)

            }
        }
    }
}

struct MatchCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        MatchCapsuleView(matchTime: "9月26日14:00-17:00", matchLocation: "6号羽毛球馆",matchDetail: "林丹-李宗伟")
    }
}
