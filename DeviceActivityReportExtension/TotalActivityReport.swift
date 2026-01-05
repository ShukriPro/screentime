//
//  TotalActivityReport.swift
//  DeviceActivityReportExtension
//
//  Created by Shukri Ali on 02/01/2026.
//

import DeviceActivity
import ExtensionKit
import SwiftUI


struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (String) -> TotalActivityView
    
    func makeConfiguration(
        representing data: DeviceActivityResults<DeviceActivityData>
    ) async -> String {

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll

        var total: TimeInterval = 0

        for await day in data {
            for await segment in day.activitySegments {
                // 🔑 applications used in this segment
                for app in segment.applications {
                    if selectedApplicationTokens.contains(app.token) {
                        total += segment.totalActivityDuration
                        break
                    }
                }
            }
        }

        return formatter.string(from: total) ?? "0m"
    }






}
