//
//  AppContentColumn.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftData
import SwiftUI

struct AppContentColumn: View {
    @Query private var reminders: [Reminder]
    @Binding var selectedScreen: AppScreen?
    @Binding var selectedReminder: Reminder?
    var body: some View {
        if let screen = selectedScreen {
            screen.destination(reminders: filteredReminders(for: selectedScreen ?? .today), $selectedReminder.animation())
        } else {
            ContentUnavailableView("Select from the sidebar", systemImage: "sidebar.left")
        }
    }
    private func filteredReminders(for screen: AppScreen) -> [Reminder] {
        reminders.filter { screen.shouldInclude(date: $0.dueDate )}
    }
}

#Preview {
    AppContentColumn(selectedScreen: .constant(.all), selectedReminder: .constant(.previewReminders[0]))
}
