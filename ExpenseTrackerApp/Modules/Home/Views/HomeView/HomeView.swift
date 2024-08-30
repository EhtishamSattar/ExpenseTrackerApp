import SwiftUI

struct HomeView: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var selectedImageData: Data? = nil
    @State private var savedImageURL: URL? = nil
    //@State private var selectedExpense: Expense? = nil
    //@State var reload : Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 8) {
                ExpenseListView(viewModel: expenseTracker)
                Spacer()
                Text("Total Expense: \(expenseTracker.calculateTotalExpenseAmount(), specifier: "%.2f") Rs")
                    .font(.title3)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                            
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .foregroundColor(Color("ThemeColor"))
                                .padding(7)
                                .background(Circle().fill(Color.white))
                                .shadow(radius: 5)
                            
                            
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
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
                    destination: AddExpenseView(expenseTracker: expenseTracker, expenseDetail: expenseTracker.navigateToEditView ?? Expense(), page: "Edit"),
                    isActive: Binding<Bool>(
                        get: { expenseTracker.navigateToEditView != nil },
                        set: { isActive in
                            if !isActive {
                                expenseTracker.navigateToEditView = nil
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
                            get: { expenseTracker.selectedExpense ?? Expense() },
                            set: { expenseTracker.selectedExpense = $0 }
                        ), expenseTracker: expenseTracker
                    ),
                    isActive: Binding<Bool>(
                        get: { expenseTracker.selectedExpense != nil },
                        set: { isActive in
                            if !isActive {
                                expenseTracker.selectedExpense = nil
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
