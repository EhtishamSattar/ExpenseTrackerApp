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
    var page : String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            TextField("Expense Name", text: $expenseDetail.expenseName)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 5) // Use a rounded rectangle as the background
                        .stroke(Color("ThemeColor"), lineWidth: 1) // Apply the custom border color
                )
                
            TextField("Expense Amount", text: $expenseDetail.expenseAmount)
                .foregroundColor(Color.primary)
                .padding(5)  // Add padding first
                .background(
                    RoundedRectangle(cornerRadius: 5) // Use a rounded rectangle as the background
                        .stroke(Color("ThemeColor"), lineWidth: 1) // Apply the custom border color
                )
                //.foregroundColor(Color("ThemeColor")) // Set the text color
                

            
            HStack{
                TextField("Select Category", text: $expenseDetail.expenseCategory)
                    .padding(5)
                    .disabled(true)
                    .background(
                        RoundedRectangle(cornerRadius: 5) // Use a rounded rectangle as the background
                            .stroke(Color("ThemeColor"), lineWidth: 1) // Apply the custom border color
                    )
                    
                
                
                Spacer()
                
                Picker("", selection: $expenseDetail.expenseCategory) {
                    if expenseTracker.categories.isEmpty {
                        Image(systemName: "error.fil")
                    }else{
                        ForEach(expenseTracker.categories, id: \.self) { category in
                            
                            Text(category.name)
                                .tag(category.name)
                                .foregroundColor(.black)
                            
                        }
                    }
                    
                    
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(Color("ThemeColor"))
                .background(
                    RoundedRectangle(cornerRadius: 5) // Use a rounded rectangle as the background
                        .stroke(Color("ThemeColor"), lineWidth: 1) // Apply the custom border color
                )
                
            }
            
            Text("Take Notes of Expense")
            TextEditor(text: $expenseDetail.expenseNotes)
                //.border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .background(
                    RoundedRectangle(cornerRadius: 5) // Use a rounded rectangle as the background
                        .stroke(Color("ThemeColor"), lineWidth: 1) // Apply the custom border color
                )
            DatePicker("Time & Date", selection: $expenseDetail.expenseDateTime, displayedComponents: [.date, .hourAndMinute])
            //.padding()
                .accentColor(Color("ThemeColor"))
            
                .navigationTitle(page == "Home" ? "Add Expense" : "Edit Expense")
            
            Button {
                if(!expenseTracker.checkDataisReady(expense: expenseDetail)){
                    showingSaveButtonAlert.toggle()
                }else{
                    expenseTracker.addExpense(expenseDetail)
                    mode.wrappedValue.dismiss()
                }
                
            } label: {
                Text(page == "Home" ? "Save" : "Edit")
                    .foregroundColor(.white)
            }
            //.buttonStyle(BorderedButtonStyle())
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("ThemeColor"))
            //.disabled(expenseTracker.checkDataisReady(expense: expenseDetail) ? false : true)
            
            
            
        }
        .padding()
        .alert(isPresented: $showingSaveButtonAlert) {
                                Alert(
                                    title: Text("Inconsistent Data"),
                                    message: Text(expenseTracker.alertMessage.isEmpty ?"Please fill all the data?": "\(expenseTracker.alertMessage)")
//                                    primaryButton: .destructive(Text("Ok")) {
//                                        if let expense = expenseToDeleteEdit {
//                                            expenseTracker.deleteExpense(expense: expense)
//                                        }
//                                    },
//                                    secondaryButton: .cancel()
                                )
                            }
        
    }
}

#Preview {
    AddExpenseView(expenseTracker : ExpenseTrackerViewModel(), expenseDetail: Expense(), page : "Home")
}
