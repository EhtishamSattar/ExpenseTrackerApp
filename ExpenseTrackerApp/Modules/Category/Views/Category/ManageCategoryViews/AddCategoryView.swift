//
//  AddCategoryView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.presentationMode) var mode
//    @Binding var categories : [String]
    @State var category = Category()
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    var body: some View {
        VStack{
            
            ExpenseFormTextField(placeholderText: "Select Category", text: $category.name)
            HStack{
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color("ThemeColor"))
                }
                .buttonStyle(BorderedButtonStyle())
                
                Button  {
                    expenseTracker.categories.append(category)
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("OK")
                        .foregroundColor(Color("ThemeColor"))
                }
                .buttonStyle(BorderedButtonStyle())
                .disabled(category.name.isEmpty ? true : false )


            }
        }
        .padding()
        
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    //@State static var categories = ["Food", "Transport", "Shopping"]
    static var previews: some View {
        AddCategoryView(expenseTracker: ExpenseTrackerViewModel())
    }
}
