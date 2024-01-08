//
//  AppDetailColumn.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftUI

struct AppDetailColumn: View {
    @Binding var selectedReminder: Reminder?
    var body: some View {
        if let reminder = selectedReminder {
            ReminderDetailView(reminder: reminder)
        } else {
            ContentUnavailableView("Select a reminder", systemImage: "folder")
        }
    }
}

#Preview {
    AppDetailColumn(selectedReminder: .constant(.previewReminders[0]))
}
