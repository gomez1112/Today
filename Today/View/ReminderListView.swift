//
//  ReminderListView.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftData
import SwiftUI

struct ReminderListView: View {
    @Environment(\.modelContext) private var context
    let reminders: [Reminder]
    @Binding var selectedReminder: Reminder?
    var progress: CGFloat {
        let chunkSize = 1.0 / CGFloat(reminders.count)
        let progress = reminders.reduce(0.0) {
            let chunk = $1.isComplete ? chunkSize : 0
            return $0 + chunk
        }
        return progress
    }
    var body: some View {
        NavigationStack {
            List(selection: $selectedReminder.animation()) {
                ForEach(reminders) { reminder in
                    NavigationLink {
                        ReminderDetailView(reminder: reminder)
                    } label: {
                        ReminderRowView(reminder: reminder)
                    }
                }
                .onDelete(perform: deleteReminder)

                    CircularProgressView(progress: progress)
                
            }
            .navigationTitle("Reminders")
            #if os(iOS)
            .listStyle(.grouped)
            #endif
        }
    }
    func deleteReminder(at offsets: IndexSet) {
        for offset in offsets {
            let reminder = reminders[offset]
            context.delete(reminder)
        }
    }
}

struct CircularProgressView: View {
    let progress: CGFloat
    var body: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .font(.title.weight(.ultraLight))
            .scaledToFit()
            .foregroundStyle(.blue.opacity(0.2))
            .background(
                Rectangle()
                    .fill(.blue.opacity(0.2))
                    .scaleEffect(x: 1, y: progress, anchor: .bottom)
                    .animation(.spring, value: progress)
            )
        
            .mask(
                Image(systemName: "circle.fill")
                    .resizable()
                    .font(.title.weight(.ultraLight))
                    .scaledToFit()
            )
            .foregroundStyle(.white)
    }
}
 

#Preview {
    NavigationStack {
        ReminderListView(reminders: Reminder.previewReminders, selectedReminder: .constant(Reminder.previewReminders[0]))
            .modelContainer(PreviewData.container)
    }
}

struct ReminderRowView: View {
    let reminder: Reminder
    var body: some View {
        HStack {
            Button {
                reminder.isComplete.toggle()
            } label: {
                Image(systemName: reminder.isComplete ? "circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(reminder.isComplete ? .green : .red)
            }
            .buttonStyle(.plain)
            .contentTransition(.symbolEffect(.replace))
            .imageScale(.large)
            VStack(alignment: .leading) {
                Text(reminder.title)
                Text(reminder.dueDate.dayAndTimeText)
                    .font(.caption)
            }
        }
    }
}
