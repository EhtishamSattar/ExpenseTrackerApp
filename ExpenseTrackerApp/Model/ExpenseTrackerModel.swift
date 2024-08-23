//
//  ExpenseTracker.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import Foundation

import Foundation

struct ExpenseTrackerData: Codable , Hashable {
    var expenses: [Expense]
    var categories: [Category]
}

struct Expense: Codable, Hashable, Identifiable {
    var id = UUID()  // Unique identifier for each expense
    var expenseName: String = ""
    var expenseCategory: String = ""
    var expenseDateTime: Date = Date()
    var expenseAmount: String = ""
    var expenseIsStarred: Bool = false
    var expenseNotes: String = ""

}

struct Category: Codable , Hashable{
    var name: String = ""
}
