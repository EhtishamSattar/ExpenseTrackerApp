import SwiftUI

struct CategoryView: View {
    @State private var categories = ["Food", "Transport", "Shopping"] // Sample categories

    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            .navigationTitle("Categories")
            .overlay(
                NavigationLink(destination: {
                    AddCategoryView(categories: $categories)
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
    CategoryView()
}
