import SwiftUI

struct CategoryView: View {
    //@State private var categories = ["Food", "Transport", "Shopping"] 
    @ObservedObject var expenseTracker : ExpenseTrackerViewModel
    @State var showDeleteCategoryAlert : Bool = false
    @State var categoryToDelete: Category?
    
    var body: some View {
            NavigationView {
                List {
                    ForEach(expenseTracker.categories, id: \.self) { category in
                        Text("\(category.name)")
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Delete") {
                                    if expenseTracker.hasExpenses(for: category) {
                                        categoryToDelete = category
                                        showDeleteCategoryAlert = true
                                    } else {
                                        expenseTracker.deleteCategory(category)
                                    }
                                }
                                .tint(.red)
                            }
                    }
                }
                .navigationTitle("Categories")
                .overlay(
                    NavigationLink(destination: {
                        AddCategoryView(expenseTracker: expenseTracker)
                    }, label: {
                        CircularPlusButton()
                            .padding()
                    }),
                    alignment: .bottomTrailing
                )
                .alert(isPresented: $showDeleteCategoryAlert) {
                    Alert(
                        title: Text("Confirm Delete"),
                        message: Text("This category has associated expenses. Are you sure you want to delete it?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let category = categoryToDelete {
                                expenseTracker.deleteCategory(category)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
}

#Preview{
    CategoryView(expenseTracker: ExpenseTrackerViewModel())
}
