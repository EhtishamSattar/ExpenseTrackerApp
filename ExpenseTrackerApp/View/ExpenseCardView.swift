//
//  ExpenseCardView.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//
import SwiftUI

struct ExpenseCardView : View {
    var expenseName: String
    var expenseCategory: String
    var expenseAmount: Double
    var expenseDateTime: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                Text("\(expenseCategory)")
                    .font(.subheadline)
                    .italic()
                Spacer()
                Image(systemName: "star.fill")
                    .accentColor(.yellow)
                    .foregroundColor(.yellow)
            }
            
                //.foregroundColor(.secondary)
            Text(expenseName)
                .font(.headline)
                //.foregroundColor(.primary)
            
            
            
            HStack {
                Text("Amount:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text("$\(String(format: "%.2f", expenseAmount))")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Date & Time:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text(DateFormatter.localizedString(from: expenseDateTime, dateStyle: .medium, timeStyle: .short))
                    .font(.subheadline)
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(Color("ThemeColor")) // You can set a custom background color
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


#Preview {
    ExpenseCardView(
        expenseName: "Lunch",
        expenseCategory: "Food",
        expenseAmount: 15.75,
        expenseDateTime: Date()
    )
}
