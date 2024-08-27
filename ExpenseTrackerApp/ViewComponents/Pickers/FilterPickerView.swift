//
//  FilterPickerView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 27/08/2024.
//

import SwiftUI

struct FilterPickerView: View {
    var placeholder : String
    @Binding var selectedFilter : FilterOption
    var body: some View {
        Picker("\(placeholder)", selection: $selectedFilter) {
            ForEach(FilterOption.allCases) { option in
                Text(option.rawValue).tag(option)
            }
        }
    }
}

#Preview {
    FilterPickerView(placeholder: "Filter Options", selectedFilter: Binding.constant(.date))
}
