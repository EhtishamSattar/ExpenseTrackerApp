//
//  ExpenseListView.swift
//  viewModelApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct ExpenseListView: View {
    
    @ObservedObject var viewModel : ExpenseTrackerViewModel
    @State private var showingDeleteAlert = false
    
    var body: some View {
        if viewModel.expenses.isEmpty {
            NoExpensesView()
        } else {
            List {
                ForEach($viewModel.expenses, id: \.self) { $expense in
                    ExpenseCardView(
                        expense: $expense,
                        expenseTracker: viewModel
                    )
                    .onChange(of: viewModel.selectedExpense){ newValue in
                        print("Changing SelectedExpense")
                        
                        viewModel.starExpense(expense: expense, newValue: newValue)
//                        if newValue?.id == expense.id {
//                            if let selExp = newValue {
//                                expense = selExp
//                            }
//                        }
                        
                        
                        
                    }
                    .onTapGesture {
                        viewModel.selectedExpense = expense
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete") {
                            viewModel.expenseToDeleteEdit = expense
                            showingDeleteAlert.toggle()
                        }
                        .tint(.red)
                        
                        Button("Edit") {
                            viewModel.navigateToEditView = expense
                        }
                        .tint(.green)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Confirm Delete"),
                    message: Text("Are you sure you want to delete this expense?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let expense = viewModel.expenseToDeleteEdit {
                            viewModel.deleteExpense(expense: expense)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    ExpenseListView(viewModel: ExpenseTrackerViewModel())
}
