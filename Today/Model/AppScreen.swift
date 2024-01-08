//
//  AppScreen.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftUI

enum AppScreen: String, Identifiable, Hashable, CaseIterable {
    case today
    case future
    case all
    
    var id: Self { self }
    
    @ViewBuilder
    var label: some View {
        switch self {
            case .today:
                Label("Today", systemImage: "calendar.circle")
            case .future:
                Label("Future", systemImage: "hourglass")
            case .all:
                Label("All", systemImage: "circle.grid.2x2")
        }
    }
    func shouldInclude(date: Date) -> Bool {
        let isInToday = Locale.current.calendar.isDateInToday(date)
        switch self {
            case .today:
                return isInToday
            case .future:
                return (date > Date.now) && !isInToday
            case .all:
                return true
        }
    }
    @ViewBuilder
    func destination(reminders: [Reminder], _ selectedReminder: Binding<Reminder?>) -> some View {
        ReminderListView(reminders: reminders, selectedReminder: selectedReminder)
    }
}
