//
//  GlobalData.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import Foundation
import SwiftUI

enum SportType {
    case Athletics
    case Basketball
    case CyclingRoad
    case Football
    case CyclingMTB
    case Boxing
    case Fencing
    case CanoeSlalom
    case DragonBoat
    case Swimming
    case ESport
    case None
}

var Event2Color : [SportType : UIColor] = [
    .Athletics  : .red ,
    .Basketball : .yellow ,
    .CyclingRoad: .brown ,
    .Football   : .orange ,
    .CyclingMTB : .blue ,
    .Boxing     : .red ,
    .Fencing    : .red ,
    .CanoeSlalom: .red ,
    .DragonBoat : .red ,
    .Swimming   : .red ,
    .ESport     : .purple
]

struct AsiadEvent: Identifiable {
    var id = UUID()
    var EventName : String
    var EventDate : Date
    var EventType : SportType
    var EventPos  : String
}

var subscribedAsiadEvents : [AsiadEvent] = [
    AsiadEvent(EventName: "英雄联盟表演赛", EventDate: Date.now.addingTimeInterval(86400 * 3), EventType: .ESport, EventPos: "中国杭州电竞中心"),
    AsiadEvent(EventName: "足球预选赛", EventDate: Date.now.addingTimeInterval(86400 * 4), EventType: .Football, EventPos: "杭州奥体中心")
]

struct TravelMtd : Identifiable {
    var id = UUID()
    var mtdName : String
    init(_ mtdName: String) {
        self.mtdName = mtdName
    }
}

var RecommandTravelMethod : [String : [TravelMtd]] = [
    "中国杭州电竞中心" : [TravelMtd("figure.walk"), TravelMtd("car.fill")],
    "杭州奥体中心"    : [TravelMtd("figure.walk"), TravelMtd("bus.fill"), TravelMtd("tram.fill")]
]

var MatchCapsuleTypeIdentifier: String = "drag_drop.item"

//var showInsert: Bool = false
