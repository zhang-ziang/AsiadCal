//
//  ProjView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProjView: View {
    var name: String
    var newURL = Bundle.main.url(forResource: "Trampoline", withExtension: "gif")
    var urlString: String
    @Binding var isAnimating: Bool
//    @State private var timer = Timer.publish(every: 2.18, on: .main, in: .common).autoconnect()
    var body: some View {
//        EmptyView().onReceive(timer){ _ in
//            isAnimating = false
//            timer.upstream.connect().cancel()
//        }
        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color(hue: Double.random(in: 0.4...0.6), saturation: 0.25, brightness: 0.98))
                    .fill(Color.white)
                    .shadow(color: .purple,radius: 2)
                    .frame(width:100, height:100)
//                AnimatedImage(name: "GIFtest/Trampoline.gif")
//                    .frame(width:240, height:200)
//                AnimatedImage(data: try! Data(contentsOf: URL(fileURLWithPath: "/Users/viglong/Desktop/yayunGIFs/Trampoline.gif")))
                    
//                    .frame(width:200, height:200)
//                AnimatedImage(url: URL(string: urlString),isAnimating: $isAnimating)
                AnimatedImage(name: name+".gif", bundle: Bundle.main,isAnimating: $isAnimating)
                    .playbackMode(.bounce)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 70, alignment: .center)
//                    .border(.blue)
                    .clipped()
            }
//            Button("Press to show details") {
//                isAnimating = true
//                timer = Timer.publish(every: 2.2, on: .main, in: .common).autoconnect()
//                isAnimating.toggle()
//            }
            Text(name).foregroundColor(.purple).font(.caption)
        }
        .padding()
    }
}

struct ProjView_Previews: PreviewProvider {
    @State static var isAni: Bool = false
    static let url = "https://www.hangzhou2022.cn/ztzl/dttytbfb/jjxbs/202208/W020220805803130683224.gif"
    static var previews: some View {
        ProjView(name: "Swimming",urlString: url, isAnimating: $isAni)
    }
}
