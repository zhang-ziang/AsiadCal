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
    //123
//    let theta: Float = 2*3.14159 * 200.0/360.0
    @State var nextEventID: Int = 0
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(circleAni ? Color(uiColor: ThemeColor[GlobeBackGroundName]!) : Color(uiColor: .black))
                .opacity(0.8)
                .frame(width:600, height:600, alignment: .bottom)
                .shadow(color: Color(white: 0.1, opacity: 0.9),radius: 10)
//            Text("游泳比赛\n6月18日\n水立方")
            Text(GetFormatText(id: nextEventID))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .offset(x:circleAni ? -75 : -100,
                        y:circleAni ? -220 : -200)
//            Text("山地自行车\n6月18日\n玉泉北门")
            Text(GetFormatText(id: nextEventID-1))
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
        .onDrop(of: [MatchCapsuleTypeIdentifier], delegate: AddDropDelegate(circleAni: $circleAni, circleShow: $circleShow,ondragmatch:matchesData.ondragMatch, nextEventID: $nextEventID))
    }
    
    func GetFormatText(id: Int)->String{
        if subscribedAsiadEvents.count == 0{
            return "..."
        }
        if id<0{
            return "..."
        }
        if id>=subscribedAsiadEvents.count{
            return "..."
        }
//        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: subscribedAsiadEvents[id].EventDate)
        let day = calendar.component(.day, from: subscribedAsiadEvents[id].EventDate)
        return subscribedAsiadEvents[id].EventName + "\n"
             + String(month) + "月" + String(day) + "日\n"
             + subscribedAsiadEvents[id].EventPos
    }
}

struct AddDropDelegate : DropDelegate {
    
//    let todoStatus: TodoStatus
//    let todoList: TodoList
    @Binding var circleAni: Bool
    @Binding var circleShow: Bool
    var ondragmatch: Match?
    @Binding var nextEventID: Int
//    var matchdate: Date = Date.now
    func validateDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - validateDrop() called")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let matchdate = dateFormatter.date(from: ondragmatch!.matchDate)!
        
        nextEventID = FindNextEventID(EventDate: matchdate)
        withAnimation{
            circleAni = true
        }
        return true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        print("AddDropDelegate - performDrop() called")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let matchdate = dateFormatter.date(from: ondragmatch!.matchDate)!
        
        if !RecommandTravelMethod.contains(where: {$0.key == ondragmatch!.Location}){
            RecommandTravelMethod[ondragmatch!.Location] = [TravelMtd("figure.walk"), TravelMtd("car.fill")]
        }

        AddEvent(EventName: ondragmatch!.projTag.toString()+ondragmatch!.title, EventDate: matchdate, EventType: ondragmatch!.projTag, EventPos: ondragmatch!.Location)
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

