import SwiftUI

struct CategoryView: View {
    //1.0 -> @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    
    @ObservedObject var expenseCategoryViewModel : CategoryViewModel
    
    init(expenseTracker: ExpenseTrackerViewModel) {
       //1.1 ->  self.expenseTracker = expenseTracker
        self.expenseCategoryViewModel = CategoryViewModel(expense: expenseTracker)
    }
    
    var body: some View {
            NavigationView {
                CategoryListView(categoryTracker: expenseCategoryViewModel)
                .navigationTitle("Categories")
            }
            .overlay(
                NavigationLink(destination: {
                    AddCategoryView(categoryTracker: expenseCategoryViewModel)
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
