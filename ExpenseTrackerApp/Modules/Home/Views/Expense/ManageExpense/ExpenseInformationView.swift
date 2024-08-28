import SwiftUI

struct ExpenseInformationView: View {
    @Binding var expense: Expense
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    //@Binding var reload: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                StarButtonView(starStatus:  $expense.expenseIsStarred)
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
        .onChange(of: expenseTracker.expenses, perform: { newValue in
            
            expense = expenseTracker.findExpense(expense)
        })
        .padding()
        .navigationTitle("Expense Info")
        .navigationBarItems(trailing: NavigationLink(destination: {
            AddExpenseView(expenseTracker: expenseTracker, expenseDetail: expense, page: "Edit")
        }, label: {
            Text("Edit")
        }))
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}

