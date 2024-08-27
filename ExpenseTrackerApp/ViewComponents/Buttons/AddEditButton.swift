//
//  AddEditButton.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct AddEditButton: View {
    var page = "Home"
    @ObservedObject var expenseTracker : ExpenseTrackerViewModel
    var expense : Expense
    @Binding var showingSaveButtonAlert : Bool 
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        
        Button {
            if(!expenseTracker.checkDataisReady(expense: expense)){
                showingSaveButtonAlert.toggle()
            }else{
                expenseTracker.addExpense(expense)
                mode.wrappedValue.dismiss()
            }
            
        } label: {
            Text(page == "Home" ? "Save" : "Edit")
                .foregroundColor(.white)
                .padding()
                .frame(width: 380)
                .background(Color("ThemeColor"))
        }
        //.buttonStyle(BorderedButtonStyle())
        .disabled(expenseTracker.checkDataisReady(expense: expense) ? false : true)
        
    }
}

#Preview {
    AddEditButton(page: "Home", expenseTracker: ExpenseTrackerViewModel(), expense: Expense(), showingSaveButtonAlert: Binding.constant(false))
}
