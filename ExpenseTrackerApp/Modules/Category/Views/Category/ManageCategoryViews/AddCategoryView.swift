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
    @State var showAddCategoryFailAlert : Bool = false
    var body: some View {
        VStack{
            Text("Add Category")
                .font(.title)
                .bold()
            ExpenseFormTextField(placeholderText: "Add Category", text: $category.name)
            HStack{
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color("ThemeColor"))
                }
                .buttonStyle(BorderedButtonStyle())
                
                Button  {
                    if categoryTracker.addCategory(category) {
                        mode.wrappedValue.dismiss()
                    }else {
                        showAddCategoryFailAlert = true
                    }
                    
                } label: {
                    Text("Add")
                        .foregroundColor(Color("ThemeColor"))
                }
                .buttonStyle(BorderedButtonStyle())
                .disabled(category.name.isEmpty ? true : false )
                .alert(isPresented: $showAddCategoryFailAlert, content: {
                    Alert(title: Text("Category Addition failed"), message: Text("This category already existed"))
                })


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
