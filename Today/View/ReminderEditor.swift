//
//  ReminderEditor.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftData
import SwiftUI

struct ReminderEditor: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var dueDate = Date()
    @State private var notes = ""
    var reminder: Reminder?
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("", text: $title)
                }
                Section("Date") {
                    DatePicker("", selection: $dueDate)
                       // .datePickerStyle(.graphical)
                }
                Section("Notes") {
                    TextField("", text: $notes, axis: .vertical)
                }
            }
            .formStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            #if os(macOS)
            .padding()
            #else
            .navigationBarTitleDisplayMode(.inline)
            #endif
            
        }
        .onAppear {
            if let reminder {
                title = reminder.title
                dueDate = reminder.dueDate
                notes = reminder.notes ?? ""
            }
        }
    }
    private var editorTitle: String {
        reminder == nil ? "Add Reminder" : "Edit Reminder"
    }
    private func save() {
        if let reminder {
            reminder.title = title
            reminder.dueDate = dueDate
            reminder.notes = notes
        } else {
            let newReminder = Reminder(title: title, dueDate: dueDate, notes: notes)
            context.insert(newReminder)
        }
    }
}

#Preview {
    ReminderEditor()
        .modelContainer(PreviewData.container)
}
