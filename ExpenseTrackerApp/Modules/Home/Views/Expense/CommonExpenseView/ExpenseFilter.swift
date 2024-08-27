import SwiftUI

struct FilterScreen: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text("Select Filter Option")) {
                        FilterPickerView(placeholder: "Filter Options", selectedFilter: $expenseTracker.selectedFilter)
                            .pickerStyle(SegmentedPickerStyle())
                            .onChange(of: expenseTracker.selectedFilter) { newValue in
                                expenseTracker.updateFilter(newValue)
                                mode.wrappedValue.dismiss()
                            }
                    }
                }
                .padding(.zero)
            }
            .navigationTitle("Filter Options")
        }
        .padding(.zero)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen(expenseTracker: ExpenseTrackerViewModel())
    }
}
