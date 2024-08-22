//
//  AddExpenseView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var expenseName: String = ""
    @State private var selectedCategory: String = ""
    @State private var date = Date()
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
                TextField("Expense Name", text: $expenseName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
                
                HStack{
                    TextField("Select Category", text: $selectedCategory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(5)
                    
                    Spacer()
                    
                    Picker("", selection: $selectedCategory) {
                        Text("Food").tag("Food")
                        Text("Transport").tag("Transport")
                        Text("Shopping").tag("Shopping")
                        // Add more categories as needed
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(Color("ThemeColor"))
                    .padding(5)
                }
                
                DatePicker("Time & Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    //.padding()
                    .accentColor(Color("ThemeColor"))
            
                    .navigationTitle("Add Expense")
            
        }
        .padding()
        
    }
}

#Preview {
    AddExpenseView()
}
