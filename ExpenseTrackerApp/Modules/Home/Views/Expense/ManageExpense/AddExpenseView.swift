//
//  AddExpenseView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var mode
    @ObservedObject var expenseTracker : ExpenseTrackerViewModel
    @State var expenseDetail : Expense
    @State var showingSaveButtonAlert : Bool = false
    @State var value : String = ""
    @State var showAddCategoryView : Bool = false
    var page : String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ExpenseFormTextField(placeholderText : "Expense Name",text: $expenseDetail.expenseName)
            TextField("Expense amount",text: $value)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("ThemeColor"), lineWidth: 1)
                )
                .onChange(of: value) { newValue in
                    if let amount = Double(newValue) {
                        expenseDetail.expenseAmount = amount                    }
                    
                }
                .onAppear(
                    perform: {
                        value = String(expenseDetail.expenseAmount)
                    }
                )
            HStack{
                ExpenseFormTextField(placeholderText : "Expense category",text: $expenseDetail.expenseCategory)
                    .disabled(true)
                
                if !expenseTracker.categories.isEmpty {
                    Spacer()
                    PickerView(selectedText : $expenseDetail.expenseCategory, expenseTracker: expenseTracker)
                        .pickerStyle(MenuPickerStyle())
                }else {
                    NavigationLink {
                        CategoryView(expenseTracker: expenseTracker)
                    } label: {
                        Text("Add Category")
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("ThemeColor"), lineWidth: 1)
                            )
                    }
                }
                
            }
            
            Text("Take Notes of Expense")
            
            NotesTextEditor(text: $expenseDetail.expenseNotes)
            
            DatePickerView(placeholder: "Time/Date", date: $expenseDetail.expenseDateTime)
            
                .navigationTitle(page == "Home" ? "Add Expense" : "Edit Expense")
            
            AddEditButton(page: page, expenseTracker: expenseTracker, expense: expenseDetail, showingSaveButtonAlert: $showingSaveButtonAlert)
            
        }
        .padding()
        .alert(isPresented: $showingSaveButtonAlert) {
            Alert(
                title: Text("Inconsistent Data"),
                message: Text(expenseTracker.alertMessage.isEmpty ? "Please fill all the data?": "\(expenseTracker.alertMessage)")
            )
        }
        
    }
}

#Preview {
    AddExpenseView(expenseTracker : ExpenseTrackerViewModel(), expenseDetail: Expense(), page : "Home")
}
