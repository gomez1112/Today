//
//  HomeView.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @State private var screen: AppScreen? = .today
    @State private var reminder: Reminder?
    var body: some View {
        if prefersTabNavigation {
            AppTabView(reminder: $reminder, selectedScreen: $screen)
        } else {
            NavigationSplitView(columnVisibility: .constant(.all)) {
            AppSidebarList(selectedScreen: $screen)
        } content: {
            AppContentColumn(selectedScreen: $screen, selectedReminder: $reminder)
        } detail: {
            AppDetailColumn(selectedReminder: $reminder)
        }
    }
    }
}

#Preview {
    HomeView()
}
