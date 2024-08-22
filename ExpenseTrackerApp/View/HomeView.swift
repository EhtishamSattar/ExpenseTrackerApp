import SwiftUI

struct HomeView: View {
    //    @State private var expenseName: String = ""
    //    @State private var selectedCategory: String = ""
    //    @State private var date = Date()
    var page : String = "Home"
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 10){
                ExpenseCardView(
                    expenseName: "Lunch",
                    expenseCategory: "Food",
                    expenseAmount: 15.75,
                    expenseDateTime: Date()
                )
                
                ExpenseCardView(
                    expenseName: "Oversixed T-Shirt",
                    expenseCategory: "Shopping",
                    expenseAmount: 10.75,
                    expenseDateTime: Date()
                )
                
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .navigationTitle("Home")
            .overlay(
                NavigationLink(destination: {
                    AddExpenseView()
                }, label: {
                    CircularPlusButton()
                        .padding()
                }),
                alignment: .bottomTrailing // Move alignment here, outside the closure
            )


        }
        
        
    }
}

#Preview{
    HomeView()
}
