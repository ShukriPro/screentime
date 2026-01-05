//
//  ContentView.swift
//  timescreen
//
//  Created by Shukri Ali on 02/01/2026.
//
import SwiftUI
import FamilyControls
import DeviceActivity

struct ContentView: View {

    @State private var selection = FamilyActivitySelection()

    var body: some View {
        VStack(spacing: 16) {

            // 1) App picker (user selects apps like Instagram)
            FamilyActivityPicker(selection: $selection)
                .frame(height: 300)

            // 2) Report showing usage (filtered by date)
            DeviceActivityReport(
                .totalActivity,
                filter: todayFilter
            )
        }
        .padding()
        // 3) Save selected apps to App Group for the extension
        .onChange(of: selection) { _, newValue in
            AppGroupStore.save(tokens: newValue.applicationTokens)
        }
        // 4) Request Screen Time permission once
        .task {
            await requestPermission()
        }
    }

    // REQUIRED: tells iOS WHICH time range to fetch
    private var todayFilter: DeviceActivityFilter {
        let start = Calendar.current.startOfDay(for: Date())
        let end = Date()
        let interval = DateInterval(start: start, end: end)

        return DeviceActivityFilter(
            segment: .daily(during: interval),
            users: .all,
            devices: .all
        )
    }

    // REQUIRED: Screen Time permission
    @MainActor
    private func requestPermission() async {
        try? await AuthorizationCenter.shared
            .requestAuthorization(for: .individual)
    }
}

