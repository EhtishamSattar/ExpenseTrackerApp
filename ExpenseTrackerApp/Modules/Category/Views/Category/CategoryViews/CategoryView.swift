import SwiftUI

struct CategoryView: View {
    //@State private var categories = ["Food", "Transport", "Shopping"] 
  //  @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @ObservedObject var expenseCategoryViewModel : CategoryViewModel
    
    init(expenseTracker: ExpenseTrackerViewModel) {
       // self.expenseTracker = expenseTracker
        self.expenseCategoryViewModel = CategoryViewModel(expense: expenseTracker)
    }
    
    var body: some View {
            NavigationView {
                CategoryListView(categoryTracker: expenseCategoryViewModel)
                .navigationTitle("Categories")
            }
            .overlay(
                NavigationLink(destination: {
                    AddCategoryView(expenseTracker: expenseCategoryViewModel.expense)
                }, label: {
                    CircularPlusButton()
                        .padding()
                }),
                alignment: .bottomTrailing
            )
        }
}

#Preview{
    CategoryView(expenseTracker: ExpenseTrackerViewModel())
}
