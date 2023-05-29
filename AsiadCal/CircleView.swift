//
//  CircleView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI
import Foundation

struct CircleView: View {
    @Binding var circleAni: Bool
//    let r: Float = 200
//    let theta: Float = 2*3.14159 * 200.0/360.0
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(circleAni ? Color(uiColor: .systemPurple):Color(uiColor: .black))
                .opacity(0.8)
                .frame(width:600, height:600, alignment: .bottom)
                .shadow(color: Color(white: 0.1, opacity: 0.9),radius: 10)
            Text("游泳比赛\n6月18日\n水立方")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .offset(x:circleAni ? -75 : -100,
                        y:circleAni ? -220 : -200)
            Text("山地自行车\n6月18日\n玉泉北门")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .offset(x:circleAni ? -200: -225,
                        y:circleAni ? 95: 75)
            Text("+")
                .scaleEffect(circleAni ? 2.0 : 1.0)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 80))
                .multilineTextAlignment(.center)
//                .offset(x: -200,y:-75)
                .offset(x: circleAni ? -200 : -150,y:circleAni ? -100 : -75)
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    @State static var circleAni: Bool = false
    static var previews: some View {
        CircleView(circleAni: $circleAni)
    }
}

