//
//  BackGroundView.swift
//  AsiadCal
//
//  Created by ChenSir on 2023/6/3.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectColorView : View {
    var gifName : String
    var colorName : String
    var textColor : Color
    var bkgColor : Color = Color(red: 0.96, green: 0.96, blue: 0.96)
    @State var isAnimated : Bool = true
    @Binding var GlobeBackGroundName : String
    var body: some View {
        Button {
            withAnimation {
                GlobeBackGroundName = gifName
            }
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 330, height: 60)
                    .foregroundColor(bkgColor)
                HStack{
                    AnimatedImage(name: gifName, bundle: Bundle.main, isAnimating: $isAnimated)
                        .playbackMode(.bounce)
                        .frame(width: 100, height: 30)
                        .opacity(0.6)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 15)
                        )
                        .zIndex(7.0)
                        .onAppear{
                            isAnimated = true
                        }
                    Spacer()
                    Text(colorName)
                        .foregroundColor(textColor)
                }
                .frame(width: 300)
            }
            
        }
    }
}

struct BackGroundView: View {
    
    //    var ViewHeight : Double = 0
    @Binding var GlobeBackGroundName : String
    var body: some View {
        VStack {
            SelectColorView(gifName: "giphy.gif",   colorName: "亚运紫", textColor: .purple, GlobeBackGroundName: $GlobeBackGroundName)
            SelectColorView(gifName: "blue.gif",    colorName: "亚运蓝", textColor: .blue, GlobeBackGroundName: $GlobeBackGroundName)
            SelectColorView(gifName: "green.gif",   colorName: "亚运绿", textColor: .green, GlobeBackGroundName: $GlobeBackGroundName)
            SelectColorView(gifName: "red.gif",     colorName: "亚运红", textColor: .red, GlobeBackGroundName: $GlobeBackGroundName)
            SelectColorView(gifName: "white.gif",   colorName: "亚运灰", textColor: .gray, GlobeBackGroundName: $GlobeBackGroundName)
            SelectColorView(gifName: "yellow.gif",  colorName: "亚运黄", textColor: .yellow, GlobeBackGroundName: $GlobeBackGroundName)
        }
//        .transition(.move(edge: .bottom).combined(with: .opacity))
        .offset(y: -120)
    }
}

struct BackGroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundView(GlobeBackGroundName: .constant("giphy.gif"))
    }
}
