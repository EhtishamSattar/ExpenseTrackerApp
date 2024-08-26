//
//  DateFormatter.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import Foundation

class DateFormatter {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
