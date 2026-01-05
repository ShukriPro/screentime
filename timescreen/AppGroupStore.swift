//
//  AppGroupStore.swift
//  timescreen
//
//  Created by Shukri Ali on 02/01/2026.
//

import Foundation
import FamilyControls


enum AppGroupStore {

    static let suite = UserDefaults(
        suiteName: "group.com.justshukri.timescreen"
    )!

    static func save(tokens: Set<ApplicationToken>) {
        let data = try? JSONEncoder().encode(tokens)
        suite.set(data, forKey: "selectedApps")
    }

    static func load() -> Set<ApplicationToken> {
        guard
            let data = suite.data(forKey: "selectedApps"),
            let tokens = try? JSONDecoder().decode(
                Set<ApplicationToken>.self,
                from: data
            )
        else {
            return []
        }
        return tokens
    }
}
