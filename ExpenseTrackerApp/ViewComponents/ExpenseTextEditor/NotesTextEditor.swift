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
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("ThemeColor"), lineWidth: 1)
            )
    }
}

#Preview {
    NotesTextEditor(text: Binding.constant("Preview NOtes"))
}
