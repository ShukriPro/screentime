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
        TotalActivityReport { activityData in
            TotalActivityView(totalActivity: activityData)
        }
    }
}
