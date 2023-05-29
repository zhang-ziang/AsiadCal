//
//  MatchCapsuleView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI

struct MatchCapsuleView: View {
    @Binding var showInsert: Bool
//    var matchTitle: String
    var matchTime: String
    var matchLocation: String
    var matchDetail: String
    @State private var offset = CGSize.zero
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
    static var previews: some View {
        MatchCapsuleView(showInsert: $sIn, matchTime: "9月26日14:00-17:00", matchLocation: "6号羽毛球馆",matchDetail: "林丹-李宗伟")
    }
}
