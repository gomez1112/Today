//
//  ReminderDetailView.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftData
import SwiftUI

struct ReminderDetailView: View {
    @Environment(\.modelContext) private var context
    @State private var isEditing = false
    @State private var isDeleting = false
    var reminder: Reminder?
    var body: some View {
        if let reminder {
            List {
                Text(reminder.title)
                    .font(.headline)
                Label(reminder.dueDate.dayText, systemImage: "calendar.circle")
                    .font(.subheadline)
                Label(reminder.dueDate.formatted(date: .omitted, time: .shortened), systemImage: "clock")
                    .font(.subheadline)
                Label(
                    title: { Text(reminder.notes ?? "NA") },
                    icon: { Image(systemName: "square.and.pencil") }
                )
                .font(.subheadline)
            }
            .toolbar {
                Button {
                    isEditing = true
                } label: {
                    Label("Edit \(reminder.title)", systemImage: "pencil")
                        .help("Edit the reminder")
                }
                Button {
                    isDeleting = true
                } label: {
                    Label("Delete \(reminder.title)", systemImage: "trash")
                        .help("Delete the reminder")
                }
            }
            .sheet(isPresented: $isEditing) {
                ReminderEditor(reminder: reminder)
            }
            .alert("Delete \(reminder.title)?", isPresented: $isDeleting) {
                Button("Yes, delete \(reminder.title)", role: .destructive) {
                    delete(reminder)
                }
            }
            .navigationTitle("Reminder")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
    private func delete(_ reminder: Reminder) {
        context.delete(reminder)
    }
}

#Preview {
    NavigationStack {
        ReminderDetailView(reminder: Reminder(title: "Task 1"))
            .modelContainer(PreviewData.container)
    }
}
