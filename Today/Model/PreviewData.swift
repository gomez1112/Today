//
//  PreviewData.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import Foundation
import SwiftData

actor PreviewData {
    static var container: ModelContainer = {
       createContainer
    }()
    
    static private var createContainer: ModelContainer {
        let schema = Schema([Reminder.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            Task { @MainActor in
                Reminder.insertSampleData(context: container.mainContext)
            }
            return container
        } catch {
            fatalError("Cannot load container: \(error.localizedDescription)")
        }
    }
}
