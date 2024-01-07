//
//  Reminder.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import Foundation
import SwiftData

@Model
final class Reminder {
    var title = ""
    var dueDate = Date()
    var notes: String?
    var isComplete = false
    
    init(title: String = "", dueDate: Date = Date(), notes: String? = nil, isComplete: Bool = false) {
        self.title = title
        self.dueDate = dueDate
        self.notes = notes
        self.isComplete = isComplete
    }
}
