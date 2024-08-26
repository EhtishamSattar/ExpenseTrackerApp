//
//  NotesTextEditor.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 26/08/2024.
//

import SwiftUI

struct NotesTextEditor: View {
    @Binding var text : String
    var body: some View {
        TextEditor(text: $text)
            //.border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("ThemeColor"), lineWidth: 1)
            )
    }
}

#Preview {
    NotesTextEditor(text: Binding.constant("Preview NOtes"))
}
