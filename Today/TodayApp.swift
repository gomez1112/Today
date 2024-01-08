//
//  TodayApp.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftData
import SwiftUI

@main
struct TodayApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Reminder.self, isUndoEnabled: true)
    }
}
