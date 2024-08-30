//
//  FilterPickerView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 27/08/2024.
//

import SwiftUI

struct SortPickerView: View {
    var placeholder : String
    @Binding var selectedSortOption : SortOption
    var body: some View {
        Picker("\(placeholder)", selection: $selectedSortOption) {
            ForEach(SortOption.allCases) { option in
                Text(option.rawValue).tag(option)
            }
        }
    }
}

#Preview {
    SortPickerView(placeholder: "Filter Options", selectedSortOption: Binding.constant(.date))
}
