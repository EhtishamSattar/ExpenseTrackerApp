//
//  ExpenseFormTextField.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct ExpenseFormTextField: View {
    var placeholderText : String
    @Binding var text : String
    var body: some View {
        
        TextField("\(placeholderText)", text: $text)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("ThemeColor"), lineWidth: 1)
            )
                  
    }
}

#Preview {
    ExpenseFormTextField(placeholderText : "Preview Text" ,text: Binding.constant("Empty"))

}
