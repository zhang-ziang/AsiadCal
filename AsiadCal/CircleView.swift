//
//  CircleView.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import SwiftUI
import Foundation

struct CircleView: View {
    @EnvironmentObject var matchesData : MatchesData
    @Binding var circleAni: Bool
    @Binding var circleShow: Bool
    @Binding var GlobeBackGroundName: String
//    let r: Float = 200
//    let theta: Float = 2*3.14159 * 200.0/360.0
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(circleAni ? Color(uiColor: ThemeColor[GlobeBackGroundName]!) : Color(uiColor: .black))
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
        .onDrop(of: [MatchCapsuleTypeIdentifier], delegate: AddDropDelegate(circleAni: $circleAni, circleShow: $circleShow,ondragmatch:matchesData.ondragMatch))
    }
}

struct AddDropDelegate : DropDelegate {
    
//    let todoStatus: TodoStatus
//    let todoList: TodoList
    @Binding var circleAni: Bool
    @Binding var circleShow: Bool
    var ondragmatch: Match?
    
    func validateDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - validateDrop() called")
        withAnimation{
            circleAni = true
        }
        return true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - performDrop() called")
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let matchdate = dateFormatter.date(from: ondragmatch!.matchDate)
        if !RecommandTravelMethod.contains(where: {$0.key == ondragmatch!.Location}){
            RecommandTravelMethod[ondragmatch!.Location] = [TravelMtd("figure.walk"), TravelMtd("car.fill")]
        }
        subscribedAsiadEvents.append(
            AsiadEvent(EventName: ondragmatch!.projTag.toString()+ondragmatch!.title, EventDate: matchdate!, EventType: ondragmatch!.projTag, EventPos: ondragmatch!.Location)
        )
        withAnimation{
            circleAni = false
            circleShow = false
        }
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print("AddDropDelegate - dropEntered() called")
        withAnimation{
            circleAni = true
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("AddDropDelegate - dropUpdated() called")
        return DropProposal(operation: .move)
    }
    
    func dropExited(info: DropInfo) {
        print("AddDropDelegate - dropExited() called")
        withAnimation{
            circleAni = false
        }
    }
    
}



struct CircleView_Previews: PreviewProvider {
    @State static var matchesData = MatchesData()
    @State static var circleAni: Bool = false
    @State static var circleShow: Bool = false
    @State static var GlobeBackGroundName : String = "purple.gif"
    static var previews: some View {
        CircleView(circleAni: $circleAni, circleShow: $circleShow, GlobeBackGroundName: $GlobeBackGroundName)
            .environmentObject(matchesData)
    }
}

