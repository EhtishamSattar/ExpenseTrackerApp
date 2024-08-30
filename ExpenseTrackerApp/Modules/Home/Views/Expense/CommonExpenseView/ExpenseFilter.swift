import SwiftUI

struct FilterScreen: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @Environment(\.presentationMode) var mode
    @State var optSelected: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text("Select Sorting Option")) {
                        SortPickerView(placeholder: "Sorting Options", selectedSortOption: $expenseTracker.selectedSortOption)
                            .onChange(of: expenseTracker.selectedSortOption) { newValue in
                                expenseTracker.updateSorting(newValue)
                                mode.wrappedValue.dismiss()
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 150)
                
                Form {
                    Section(header: Text("Select Filter Option")) {
                        FilterPickerView(expenseTracker: expenseTracker, optSelected: $optSelected)
                            .onChange(of: optSelected) { newValue in
                                //expenseTracker.updateFiltering(newValue)
                                mode.wrappedValue.dismiss()
                            }
                    }
                }
                .padding(.zero)
                .background(Color.green)
                Spacer()
            }
            .navigationTitle("Options")
        }
        .padding(.zero)
        //.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen(expenseTracker: ExpenseTrackerViewModel())
    }
}
