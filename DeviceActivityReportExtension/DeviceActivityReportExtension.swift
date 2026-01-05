//
//  DeviceActivityReportExtension.swift
//  DeviceActivityReportExtension
//
//  Created by Shukri Ali on 02/01/2026.
//

import DeviceActivity
import ExtensionKit
import SwiftUI

@main
struct ActivityReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
