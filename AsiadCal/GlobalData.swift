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
}

var subscribedAsiadEvents : [AsiadEvent] = [
    AsiadEvent(EventName: "英雄联盟表演赛", EventDate: Date.now.addingTimeInterval(86400 * 3), EventType: .ESport),
    AsiadEvent(EventName: "足球预选赛", EventDate: Date.now.addingTimeInterval(86400 * 4), EventType: .Football)
]

var MatchCapsuleTypeIdentifier: String = "drag_drop.item"

//var showInsert: Bool = false
