import SwiftUI

struct HomeView: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var selectedImageData: Data? = nil
    @State private var savedImageURL: URL? = nil
    
    @State private var showingDeleteAlert = false
    @State private var expenseToDeleteEdit: Expense?
    @State private var navigateToEditView: Expense? = nil
    @State private var selectedExpense: Expense? = nil
    @State var reload : Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 8) {
                if expenseTracker.expenses.isEmpty {
                    NoExpensesView()
                } else {
                    List {
                        ForEach($expenseTracker.expenses, id: \.self) { $expense in
                            ExpenseCardView(
                                expense: $expense,
                                expenseTracker: expenseTracker
                            )
                            .onChange(of: expense.expenseIsStarred){ newValue in
                                print("Home View")
                            }
                            .onTapGesture {
                                selectedExpense = expense
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Delete") {
                                    expenseToDeleteEdit = expense
                                    showingDeleteAlert.toggle()
                                }
                                .tint(.red)
                                
                                Button("Edit") {
                                    navigateToEditView = expense
                                }
                                .tint(.green)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .alert(isPresented: $showingDeleteAlert) {
                        Alert(
                            title: Text("Confirm Delete"),
                            message: Text("Are you sure you want to delete this expense?"),
                            primaryButton: .destructive(Text("Delete")) {
                                if let expense = expenseToDeleteEdit {
                                    expenseTracker.deleteExpense(expense: expense)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                Spacer()
                Text("Total Expense: \(expenseTracker.calculateTotalExpenseAmount(), specifier: "%.2f")")
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                Spacer()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Home")
            .font(.title3)
            .navigationBarItems(
                leading: Button(action: {
                    isImagePickerPresented = true
                }) {
                    ZStack {
                            // Button with icon
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .foregroundColor(Color("ThemeColor"))
                                .padding(7)
                                .background(Circle().fill(Color.white))
                                .shadow(radius: 5)
                            
                            // Overlay with selected image
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill() // Adjust as needed
                                    .frame(width: 35, height: 35) // Ensure this matches the size of the button
                                    .clipShape(Circle()) // Make sure the image fits the circle shape
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: Add a border if needed
                            }
                        }
                },
                trailing: NavigationLink(
                    destination: FilterScreen(expenseTracker: expenseTracker)
                ) {
                    Text("Filter")
                        .foregroundColor(Color("ThemeColor"))
                }
            )
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage, selectedImageData: $selectedImageData, savedImageURL: $savedImageURL)
            }
            .background(
                NavigationLink(
                    destination: AddExpenseView(expenseTracker: expenseTracker, expenseDetail: navigateToEditView ?? Expense(), page: "Edit"),
                    isActive: Binding<Bool>(
                        get: { navigateToEditView != nil },
                        set: { isActive in
                            if !isActive {
                                navigateToEditView = nil
                            }
                        }
                    )
                ) {
                    EmptyView()
                }
            )
            .overlay(
                NavigationLink(
                    destination: AddExpenseView(expenseTracker: expenseTracker, expenseDetail: Expense(), page: "Home")
                ) {
                    CircularPlusButton()
                        .padding()
                },
                alignment: .bottomTrailing
            )
            .background(
                NavigationLink(
                    destination: ExpenseInformationView(
                        expense: Binding(
                            get: { selectedExpense ?? Expense() },
                            set: { selectedExpense = $0 }
                        ),
                        expenseTracker: expenseTracker,
                        reload: $reload
                    ),
                    isActive: Binding<Bool>(
                        get: { selectedExpense != nil },
                        set: { isActive in
                            if !isActive {
                                selectedExpense = nil
                            }
                        }
                    )
                ) {
                    EmptyView()
                }
            )
        }
    }
}

#Preview {
    HomeView(expenseTracker: ExpenseTrackerViewModel())
}
