//
//  GlobalData.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/29.
//

import Foundation
import SwiftUI

enum SportType: Decodable {
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
    case RugbySevens
    case TableTennis
    case ESport
    case None
    case Amateur
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = SportType(rawValue: label)
    }
    
    init(rawValue: String){
        switch rawValue{
            case "Athletics":
                self = .Athletics
            case "Basketball":
                self = .Basketball
            case "CyclingRoad":
                self = .CyclingRoad
            case "Football":
                self = .Football
            case "CyclingMTB":
                self = .CyclingMTB
            case "Boxing":
                self = .Boxing
            case "Fencing":
                self = .Fencing
            case "CanoeSlalom":
                self = .CanoeSlalom
            case "DragonBoat":
                self = .DragonBoat
            case "Swimming":
                self = .Swimming
            case "ESport":
                self = .ESport
            case "RugbySevens":
                self = .RugbySevens
            case "TableTennis":
                self = .TableTennis
            case "Amateur":
                self = .Amateur
            default:
                self = .None
        }
    }
    
    init(ID: Int){
        switch ID{
            case 0:
                self = .Athletics
            case 1:
                self = .Basketball
            case 2:
                self = .CyclingRoad
            case 3:
                self = .Football
            case 4:
                self = .CyclingMTB
            case 5:
                self = .Boxing
            case 6:
                self = .Fencing
            case 7:
                self = .CanoeSlalom
            case 8:
                self = .DragonBoat
            case 9:
                self = .Swimming
            case 10:
                self = .RugbySevens
            case 11:
                self = .TableTennis
            case 12:
                self = .ESport
            case 13:
                self = .Amateur
            default:
                self = .None
        }
    }
    
    func toString()-> String{
        switch self{
            case .Athletics:
                return "Athletics"
            case .Basketball:
                return "Basketball"
            case .CyclingRoad:
                return "CyclingRoad"
            case .Football:
                return "Football"
            case .CyclingMTB:
                return "CyclingMTB"
            case .Boxing:
                return "Boxing"
            case .Fencing:
                return "Fencing"
            case .CanoeSlalom:
                return "CanoeSlalom"
            case .DragonBoat:
                return "DragonBoat"
            case .Swimming:
                return "Swimming"
            case .RugbySevens:
                return "RugbySevens"
            case .TableTennis:
                return "TableTennis"
            case .ESport:
                return "ESport"
            case .Amateur:
                return "Amateur"
            default:
                return ""
        }
    }
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

var ThemeColor : [String : UIColor] = [
    "purple.gif"  : .purple ,
    "yellow.gif"  : .yellow ,
    "red.gif"     : .red ,
    "blue.gif"    : .blue ,
    "green.gif"   : .green ,
    "white.gif"   : .gray
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

//var GlobeBackGroundName : String = "giphy.gif"

class MatchesData: ObservableObject{
    @Published var matches: [Match]
    @Published var ondragMatch: Match?
    init(){
        matches = loadMatches(filename: "matchesData")
    }
//    init(){
//        var match: Match()
//        matches = []
//    }
}

struct Match: Decodable {
    var title: String
    var matchDate: String
    var projTag: SportType
    var Location: String
    var detail_country1: String
    var detail_name1: String
    var detail_country2: String
    var detail_name2: String
//    var show_mode:
}

func loadMatches(filename fileName: String) -> [Match]{
    let data: Data
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
    else{
        fatalError("Couldn't find \(fileName) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: url)
    }catch{
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode([Match].self, from: data)
        return jsonData
    } catch {
        print("error:\(error)")
    }
    return []
}
