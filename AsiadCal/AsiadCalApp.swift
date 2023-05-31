//
//  AsiadCalApp.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/23.
//

import SwiftUI

@main
struct AsiadCalApp: App {
    @State var matchesData = MatchesData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(matchesData)
//            ProjListView().environmentObject(MatchesData())
        }
    }
}
