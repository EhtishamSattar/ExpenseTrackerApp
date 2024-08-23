import SwiftUI

struct FilterScreen: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @Environment(\.presentationMode) var mode

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {  
                Form {
                    Section(header: Text("Select Filter Option")) {
                        Picker("Filter Options", selection: $expenseTracker.selectedFilter) {
                            ForEach(FilterOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
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
        .navigationViewStyle(StackNavigationViewStyle()) // Ensure no additional padding from the NavigationView style
    }
}

struct FilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilterScreen(expenseTracker: ExpenseTrackerViewModel())
    }
}
