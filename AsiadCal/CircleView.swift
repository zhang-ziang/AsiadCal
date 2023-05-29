//
//  CircleView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI

struct CircleView: View {
    @Binding var circleAni: Bool
    var body: some View {
        ZStack{
            Circle()
                .fill(.black)
                .opacity(0.8)
                .frame(width:600, height:600, alignment: .bottom)
                .shadow(radius: 5)
            Text("游泳比赛\n6月18日\n水立方")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .offset(x: -100,y:-200)
            Text("山地自行车\n6月18日\n玉泉北门")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .offset(x: -200,y:95)
            Text("+")
                .scaleEffect(circleAni ? 2.0 : 1.0)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 80))
                .multilineTextAlignment(.center)
//                .offset(x: -200,y:-75)
                .offset(x: circleAni ? -200 : -100,y:circleAni ? -75 : -45)
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    @State static var circleAni: Bool = false
    static var previews: some View {
        CircleView(circleAni: $circleAni)
    }
}

