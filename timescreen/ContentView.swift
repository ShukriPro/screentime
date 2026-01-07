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
    @State private var isPickerPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Button to open app picker
            Button {
                isPickerPresented = true
            } label: {
                Label("Select Apps", systemImage: "app.badge.checkmark")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            // Show selected app count
            if !selection.applicationTokens.isEmpty {
                Text("\(selection.applicationTokens.count) app(s) selected")
                    .foregroundColor(.secondary)
            }
            
            // Report showing usage filtered by selected apps
            DeviceActivityReport(
                .totalActivity,
                filter: makeFilter()
            )
            .frame(maxHeight: .infinity)
        }
        .padding()
        .familyActivityPicker(
            isPresented: $isPickerPresented,
            selection: $selection
        )
        .task {
            await requestPermission()
        }
    }
    
    private func makeFilter() -> DeviceActivityFilter {
        let start = Calendar.current.startOfDay(for: Date())
        let end = Date()
        let interval = DateInterval(start: start, end: end)
        
        // If no apps/categories selected, show all activity
        if selection.applicationTokens.isEmpty && selection.categoryTokens.isEmpty {
            return DeviceActivityFilter(
                segment: .daily(during: interval),
                users: .all,
                devices: .all
            )
        }
        
        // Filter by selected apps and categories
        return DeviceActivityFilter(
            segment: .daily(during: interval),
            users: .all,
            devices: .all,
            applications: selection.applicationTokens,
            categories: selection.categoryTokens
        )
    }
    
    @MainActor
    private func requestPermission() async {
        try? await AuthorizationCenter.shared
            .requestAuthorization(for: .individual)
    }
}
