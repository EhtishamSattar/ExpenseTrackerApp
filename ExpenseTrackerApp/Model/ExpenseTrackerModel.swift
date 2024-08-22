//
//  ExpenseTracker.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import Foundation

import Foundation

struct ExpenseTrackerData: Codable {
    var expenses: [Expense]
    var categories: [Category]
}

struct Expense: Codable {
    let expenseName: String
    let expenseCategory: String
    let expenseDateTime: Date
    let expenseAmount: Double
    let expenseIsStarred: Bool
}

struct Category: Codable {
    let name: String
}
