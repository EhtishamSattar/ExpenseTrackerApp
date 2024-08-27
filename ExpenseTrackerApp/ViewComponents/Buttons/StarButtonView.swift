//
//  StarButtonView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 27/08/2024.
//

import SwiftUI

struct StarButtonView: View {
    @Binding var starStatus : Bool
    var body: some View {
        Button {
            starStatus.toggle()
        } label: {
            Image(systemName: starStatus ? "star.fill" : "star")
                .foregroundColor(.yellow)
        }
    }
}

#Preview {
    StarButtonView(starStatus : Binding.constant(false))
}
