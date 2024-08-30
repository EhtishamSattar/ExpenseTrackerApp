//
//  DatePicker.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct DatePickerView: View {
    var placeholder : String
    @Binding var date : Date
    
    var body: some View {
        DatePicker(placeholder, selection: $date, in: ...Date(),  displayedComponents: [.date, .hourAndMinute])
        .padding()
            .accentColor(Color("ThemeColor"))

            //.navigationTitle(page == "Home" ? "Add Expense" : "Edit Expense")

    }
}

//#Preview {
//    DatePickerView(placeholder : "Preview", date : Binding.constant(Date()))
//}
