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
                VStack{
                    
                    if !expenseCategoryViewModel.expense.categories.isEmpty {
                        CategoryListView(categoryTracker: expenseCategoryViewModel)
                            .navigationTitle("Categories")
                    }else{
                        NoExpensesView(message: "No Categories added yet!")
                            .navigationTitle("Categories")
                    }
                    Text("Swipe to delete category")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .italic()
                    Spacer()
                }
                
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
