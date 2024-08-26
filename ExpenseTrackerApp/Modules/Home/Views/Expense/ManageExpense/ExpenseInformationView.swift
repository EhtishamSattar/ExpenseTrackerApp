import SwiftUI

struct ExpenseInformationView: View {
    @Binding var expense: Expense  
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @Binding var reload: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Button {
                    expense.expenseIsStarred.toggle()
                } label: {
                    Image(systemName: expense.expenseIsStarred ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
            
            HStack {
                Text("Name:")
                    .fontWeight(.semibold)
                Spacer()
                Text(expense.expenseName)
            }
            
            HStack {
                Text("Category:")
                    .fontWeight(.semibold)
                Spacer()
                Text(expense.expenseCategory)
            }
            
            HStack {
                Text("Date:")
                    .fontWeight(.semibold)
                Spacer()
                Text(DateFormatter.localizedString(from: expense.expenseDateTime, dateStyle: .medium, timeStyle: .short))
                    .font(.subheadline)
            }
            
            HStack {
                Text("Amount:")
                    .fontWeight(.semibold)
                Spacer()
                Text("$\(expense.expenseAmount)")
            }
            
            VStack(alignment: .leading) {
                Text("Notes:")
                    .fontWeight(.semibold)
                Text(expense.expenseNotes.isEmpty ? "No notes" : expense.expenseNotes)
                    .italic()
                    
            }
            
            HStack {
                Text("Starred:")
                    .fontWeight(.semibold)
                Spacer()
                Text(expense.expenseIsStarred ? "⭐ Yes" : "☆ No")
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Expense Info")
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}
