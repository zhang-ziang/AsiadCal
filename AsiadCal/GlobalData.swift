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

var AsiadEvents : [AsiadEvent] = []

var MatchCapsuleTypeIdentifier: String = "drag_drop.item"

//var showInsert: Bool = false
