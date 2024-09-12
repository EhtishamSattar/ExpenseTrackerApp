import SwiftUI

struct FilterScreen: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @Environment(\.presentationMode) var mode
    @State var optSelected: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text("Select Sorting Option")
                        .font(.title3)
                        .padding(.horizontal, -20)) {
                        SortPickerView(placeholder: "Sorting Options", selectedSortOption: $expenseTracker.selectedSortOption)
                            .onChange(of: expenseTracker.selectedSortOption) { newValue in
                                expenseTracker.updateSorting(newValue)
                                mode.wrappedValue.dismiss()
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 150)
                
                
                Form {
                    
                    Section(header: VStack{
                        Text("Select Filter Option")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)
                            .padding(.horizontal, -20)
                        Text("Remove filter by chosing None")
                            .font(.caption)
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .trailing)
                    }
                        .frame(maxWidth: .infinity)
                    ) {
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
