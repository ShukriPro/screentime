//
//  AppPickerView.swift
//  timescreen
//
//  Created by Shukri Ali on 02/01/2026.
//

import SwiftUI
import FamilyControls

struct AppPickerView: View {
    @Binding var selection: FamilyActivitySelection

    var body: some View {
        FamilyActivityPicker(selection: $selection)
    }
}

