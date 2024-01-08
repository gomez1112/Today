//
//  PrefersTabNavigationEnvironmentKey.swift
//  Today
//
//  Created by Gerard Gomez on 1/7/24.
//

import SwiftUI

struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self]}
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

#if os(iOS)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        let idiom = traitCollection.userInterfaceIdiom
        return idiom == .phone || idiom == .tv
    }
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
        // Do not write
    }
}
#endif
