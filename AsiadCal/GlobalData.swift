//
//  GlobalData.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import Foundation


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
}

struct AsiadEvent {
    var EventName : String
    var EventDate : Date
    var EventType : SportType
}

var AsiadEvents : [AsiadEvent] = []
