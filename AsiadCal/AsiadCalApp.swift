//
//  AsiadCalApp.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/23.
//

import SwiftUI
import Intents

@main
struct AsiadCalApp: App {
    @State var matchesData = MatchesData()
    
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(matchesData)
//            ProjListView().environmentObject(MatchesData())
        }.onChange(of: scenePhase){ phase in
            INPreferences.requestSiriAuthorization({ status in
                
            })
        }
    }
}
