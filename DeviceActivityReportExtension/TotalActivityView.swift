//
//  TotalActivityView.swift
//  DeviceActivityReportExtension
//
//  Created by Shukri Ali on 02/01/2026.
//

import FamilyControls
import SwiftUI
import ManagedSettings

struct TotalActivityView: View {
    let totalActivity: ActivityReportData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Total time header
            VStack(alignment: .leading, spacing: 4) {
                Text("Total Screen Time")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(totalActivity.totalTime)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            // Per-app breakdown
            if totalActivity.apps.isEmpty {
                Text("No app activity")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
            } else {
                Text("Apps")
                    .font(.headline)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(totalActivity.apps) { app in
                            HStack {
                                // Real app icon + name using Apple's Label
                                Label(app.token)
                                
                                Spacer()
                                
                                // Usage time
                                Text(app.formattedDuration)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

// Preview with sample data
#Preview {
    TotalActivityView(
        totalActivity: ActivityReportData(
            totalTime: "2h 45m",
            apps: []
        )
    )
    .padding()
}
