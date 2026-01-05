//
//  DeviceActivityContext.swift
//  timescreen
//
//  Created by Shukri Ali on 02/01/2026.
//

import Foundation
import DeviceActivity
import ExtensionKit
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let totalActivity = Self("Total Activity")
}
