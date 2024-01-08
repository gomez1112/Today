//
//  AppSidebarList.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftData
import SwiftUI

struct AppSidebarList: View {
    @State private var isAddingReminder = false
    @Binding var selectedScreen: AppScreen?
    var body: some View {
        List(selection: $selectedScreen.animation()) {
            ForEach(AppScreen.allCases) { screen in
                NavigationLink(value: screen) {
                    screen.label
                }
            }
        }
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
        .navigationTitle("Today")
    }
}

#Preview {
    NavigationStack {
        AppSidebarList(selectedScreen: .constant(.all))
    }
}
