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
    
    init(){
        self.expenses = []
        self.categories = []
    }
    
    init(expenses: [Expense], categories: [Category]) {
        self.expenses = expenses
        self.categories = categories
    }
}

struct Expense: Codable, Hashable, Identifiable {
    var id = UUID()  
    var expenseName: String = ""
    var expenseCategory: String = ""
    var expenseDateTime: Date = Date()
    var expenseAmount: String = ""
    var expenseIsStarred: Bool = false
    var expenseNotes: String = ""

}


