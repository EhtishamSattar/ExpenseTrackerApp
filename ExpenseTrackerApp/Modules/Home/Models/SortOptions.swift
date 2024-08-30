//
//  FilterOptions.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import SwiftUI

enum SortOption: String, CaseIterable, Identifiable {
    case none = "None"
    case aToZ = "A to Z"
    case zToA = "Z to A"
    case date = "Date"
    case category = "Category"
    
    var id: String { self.rawValue } // Computed property are read only, cant be set
}
