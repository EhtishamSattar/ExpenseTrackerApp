import SwiftUI

struct AddCategoryView: View {
    @Environment(\.presentationMode) var mode
    @State private var category = Category()
    @ObservedObject var categoryTracker: CategoryViewModel
    @State private var showAddCategoryFailAlert: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    ExpenseFormTextField(placeholderText: "Category Name", text: $category.name)
                }

                Section {
                    
                    HStack {
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }) {
                            Label("Cancel", systemImage: "xmark.circle")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.borderless)
                        
                        Spacer()
                        
                        Button(action: {
                            if categoryTracker.addCategory(category) {
                                mode.wrappedValue.dismiss()
                            } else {
                                showAddCategoryFailAlert = true
                            }
                        }) {
                            Label("Add", systemImage: "checkmark.circle")
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(category.name.isEmpty)
                    }
                    

                    
                }
            }
            .navigationTitle("Add Category")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAddCategoryFailAlert) {
                Alert(
                    title: Text("Category Addition Failed"),
                    message: Text("This category already exists.")
                )
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(categoryTracker: CategoryViewModel(expense: ExpenseTrackerViewModel()))
    }
}
