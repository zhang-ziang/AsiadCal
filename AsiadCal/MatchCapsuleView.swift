//
//  MatchCapsuleView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI

enum ShowMode{
    case recommend
    case inlist
}
struct MatchCapsuleView: View {
    @Binding var showInsert: Bool
    var mode: ShowMode
    var match: Match
//    var matchTitle: String
//    var matchTime: String = ""
//    var matchLocation: String = ""
//    var matchDetail: String = ""
    @State private var offset = CGSize.zero
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: Color(uiColor: .systemCyan),radius: 2)
                .frame(width: 172,height: 96)
            VStack{
                HStack{
                    if mode == .inlist{
                        Text(match.title)
                            .frame(width:80, height: 28)
                            .font(.system(size: 22))
                            .bold()
                    }
                    else if mode == .recommend{
                        Text(match.projTag.toString())
                            .frame(width:80, height: 28)
                            .font(.system(size: 18))
                            .bold()
                    }
                    VStack{
                        Text("\(match.matchDate)")
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .font(.footnote)
                        Text(match.Location)
                            .font(.footnote)
                    }
                }
                HStack(alignment:.center,spacing:2){
                    Rectangle()
                        .frame(width:26, height:20)
                        .foregroundColor(.red)
                    Text(match.detail_name1 + "-" + match.detail_name2)
                        .frame(width:100, height:30)
                        .font(.system(size: 15))
                        .bold()
                    Rectangle()
                        .frame(width:26, height:20)
                        .foregroundColor(.blue)
                }
            }
        }
        .onDrag{
            withAnimation{
                showInsert = true
            }
            return NSItemProvider(item: nil, typeIdentifier: MatchCapsuleTypeIdentifier)
        }
//        .gesture(
//            DragGesture()
//                .onChanged { gesture in
//                    self.offset = gesture.translation
//                }
//
//                .onEnded { _ in
//                    self.offset = .zero
//                }
//        )
//        .offset(offset)
    }
}

struct MatchCapsuleView_Previews: PreviewProvider {
    @State static var sIn: Bool = false
    @State static var matchesData = loadMatches(filename: "matchesData")
    static var previews: some View {
        MatchCapsuleView(showInsert: $sIn, mode: .recommend,match: matchesData[0])
    }
}
