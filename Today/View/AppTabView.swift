//
//  AppTabView.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftData
import SwiftUI

struct AppTabView: View {
    @Query private var reminders: [Reminder]
    @Binding var reminder: Reminder?
    @Binding var selectedScreen: AppScreen?
    @State private var isAddingReminder = false
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedScreen.animation()) {
                ForEach(AppScreen.allCases) { screen in
                    screen.destination(reminders: filteredReminders(for: selectedScreen ?? .today), $reminder)
                        .tag(screen as AppScreen?)
                        .tabItem { screen.label }
                }
            }
            .navigationTitle(selectedScreen?.rawValue.capitalized ?? "Reminders")
            .toolbar {
                Button {
                    isAddingReminder.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddingReminder) {
                ReminderEditor(reminder: nil)
            }
        }
    }
    private func filteredReminders(for screen: AppScreen) -> [Reminder] {
        reminders.filter { screen.shouldInclude(date: $0.dueDate )}
    }
}

#Preview {
    AppTabView(reminder: .constant(.previewReminders[0]), selectedScreen: .constant(.all))
        .modelContainer(PreviewData.container)
}
