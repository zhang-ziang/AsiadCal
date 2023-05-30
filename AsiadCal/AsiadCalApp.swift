//
//  AsiadCalApp.swift
//  AsiadCal
//
//  Created by viglong on 2023/5/23.
//

import SwiftUI

@main
struct AsiadCalApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ProjListView().environmentObject(MatchesData())
        }
    }
}
