//
//  Today2WidgetLiveActivity.swift
//  Today2Widget
//
//  Created by Gerard Gomez on 1/7/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Today2WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Today2WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Today2WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Today2WidgetAttributes {
    fileprivate static var preview: Today2WidgetAttributes {
        Today2WidgetAttributes(name: "World")
    }
}

extension Today2WidgetAttributes.ContentState {
    fileprivate static var smiley: Today2WidgetAttributes.ContentState {
        Today2WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Today2WidgetAttributes.ContentState {
         Today2WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Today2WidgetAttributes.preview) {
   Today2WidgetLiveActivity()
} contentStates: {
    Today2WidgetAttributes.ContentState.smiley
    Today2WidgetAttributes.ContentState.starEyes
}
