//
//  TotalActivityReport.swift
//  DeviceActivityReportExtension
//
//  Created by Shukri Ali on 02/01/2026.
//

import DeviceActivity
import ExtensionKit
import ManagedSettings
import SwiftUI

// Model to hold per-app data
struct AppActivityData: Identifiable, Hashable {
    let id = UUID()
    let token: ApplicationToken
    let duration: TimeInterval
    let formattedDuration: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AppActivityData, rhs: AppActivityData) -> Bool {
        lhs.id == rhs.id
    }
}

// Model to hold all activity data
struct ActivityReportData {
    let totalTime: String
    let apps: [AppActivityData]
}

struct TotalActivityReport: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .totalActivity
    
    let content: (ActivityReportData) -> TotalActivityView
    
    func makeConfiguration(
        representing data: DeviceActivityResults<DeviceActivityData>
    ) async -> ActivityReportData {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        
        var totalDuration: TimeInterval = 0
        var appDurations: [ApplicationToken: TimeInterval] = [:]
        
        for await day in data {
            for await segment in day.activitySegments {
                totalDuration += segment.totalActivityDuration
                
                // Collect per-app durations
                for await category in segment.categories {
                    for await app in category.applications {
                        if let token = app.application.token {
                            appDurations[token, default: 0] += app.totalActivityDuration
                        }
                    }
                }
            }
        }
        
        // Convert to sorted array (most used first)
        let apps = appDurations
            .map { token, duration in
                AppActivityData(
                    token: token,
                    duration: duration,
                    formattedDuration: formatter.string(from: duration) ?? "0m"
                )
            }
            .sorted { $0.duration > $1.duration }
        
        let totalFormatted = formatter.string(from: totalDuration) ?? "0m"
        
        return ActivityReportData(totalTime: totalFormatted, apps: apps)
    }
}
