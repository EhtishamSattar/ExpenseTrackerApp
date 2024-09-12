import SwiftUI

struct ExpenseInformationView: View {
    @Binding var expense: Expense
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    
    var body: some View {
        Form {
            HStack{
                Text("Star this expense")
                    .font(.subheadline)
                Spacer()
                StarButtonView(starStatus:  $expense.expenseIsStarred)
            }
            Section(header: Text("Details").font(.headline)) {
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
                    Text("$\(expense.expenseAmount, specifier: "%.2f")")
                }
                VStack(alignment: .leading) {
                    Text("Notes:")
                        .fontWeight(.semibold)
                    Text(expense.expenseNotes.isEmpty ? "No notes" : expense.expenseNotes)
                        .italic()
                }
                .frame(maxHeight: 200)
                
                HStack {
                    Text("Starred:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(expense.expenseIsStarred ? "⭐ Yes" : "☆ No")
                }
            }
        }
        .onChange(of: expenseTracker.expenses) { _ in
            expense = expenseTracker.findExpense(expense)
        }
        .navigationTitle("Expense Info")
        .navigationBarItems(trailing: NavigationLink(destination: AddExpenseView(expenseTracker: expenseTracker, expenseDetail: expense, page: "Edit")) {
            Text("Edit")
        })
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}

struct EditExpenseView: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @Binding var expense: Expense
    
    var body: some View {
        // Implementation for editing the expense
        Text("Edit Expense View")
    }
}

#Preview {
    ExpenseInformationView(expense: .constant(Expense()), expenseTracker: ExpenseTrackerViewModel())
}
