//
//  ExpenseCardView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//
import SwiftUI

struct ExpenseCardView: View {
    @Binding var expense: Expense
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(expense.expenseCategory)
                    .font(.subheadline)
                    .italic()
                Spacer()
                Image(systemName: expense.expenseIsStarred ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            
            Text(expense.expenseName)
                .font(.headline)
            
            HStack {
                Text("Amount:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text("$\(expense.expenseAmount)")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Date & Time:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text(DateFormatter.localizedString(from: expense.expenseDateTime, dateStyle: .medium, timeStyle: .short))
                    .font(.subheadline)
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(Color("ThemeColor"))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


//#Preview {
//    ExpenseCardView(
//        expenseTracker: ExpenseTrackerViewModel(),
//        expense: Expense(
//            expenseName: "Groceries",
//            expenseCategory: "Food",
//            expenseDateTime: Date(),
//            expenseAmount: "45.67",
//            expenseIsStarred: true,
//            expenseNotes: "Weekly shopping"
//        )
//    )
//}



//#Preview {
//    ExpenseCardView(expense: Expense())
//}
