//
//  AddCategoryView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.presentationMode) var mode
    @State var category = Category()
    @ObservedObject var categoryTracker: CategoryViewModel
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
                    categoryTracker.addCategory(category)
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
        AddCategoryView(categoryTracker: CategoryViewModel(expense: ExpenseTrackerViewModel()))
    }
}
