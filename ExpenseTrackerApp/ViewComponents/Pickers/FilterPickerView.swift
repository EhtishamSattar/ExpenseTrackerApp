import SwiftUI

struct FilterPickerView: View {
    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var startAmount: Double = 0
    @State private var endAmount: Double = 100
    @State private var selectedFilterOption: FilterOptions = .none
    
    @Binding var optSelected : Bool
    var body: some View {
        VStack {
            Picker("Select Filter", selection: $expenseTracker.selectedFilterOption) {
                Text("Date").tag(FilterOptions.date)
                Text("Amount").tag(FilterOptions.amount)
                Text("Category").tag(FilterOptions.category)
                Text("None").tag(FilterOptions.none)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: expenseTracker.selectedFilterOption) { newValue in
                if newValue == .none {
                    expenseTracker.updateFiltering(selectedFilterOption)
                    optSelected = true
                }
            }
            
            switch expenseTracker.selectedFilterOption {
            case .date:
                VStack {
                    DatePicker("Start Date", selection: $expenseTracker.startDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    DatePicker("End Date", selection: $expenseTracker.endDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    Button("Apply Date Filter") {
                        expenseTracker.updateFiltering(.date)
                        optSelected = true
                    }
                }
                .padding()
                
            case .amount:
                VStack {
                    TextField("Min Amount", text: $expenseTracker.minAmount)
                    TextField("Max Amount", text: $expenseTracker.maxAmount)
                    Button("Apply Amount Filter") {
                        expenseTracker.updateFiltering(.amount)
                        optSelected = true
                    }
                    
                }
                .padding()
                
            case .category:
                Picker("Select Category", selection: $expenseTracker.selectedCategoryFilter) {
                    ForEach(expenseTracker.categories, id: \.self) { category in
                        Text(category.name).tag(category.name)
                    }
                }
                .onChange(of: expenseTracker.selectedCategoryFilter) { newValue in
                    expenseTracker.selectedCategoryFilter = newValue
                    //print(expenseTracker.selectedCategoryFilter)
                    expenseTracker.updateFiltering(.category)
                    optSelected = true
                }
                .padding()
                
            case .none:
                Text("No Filter Selected")
                    .padding()
                
            }
        }
    }
}

#Preview {
    FilterPickerView(expenseTracker: ExpenseTrackerViewModel(), optSelected: Binding.constant(false))
}



//import SwiftUI
//
//struct FilterPickerView: View {
//    @ObservedObject var expenseTracker: ExpenseTrackerViewModel
//    @State var startDate: Date = Date()
//    @State var endDate: Date = Date()
//    @State var ctg : String = "None"
//    var placeholder: String
//    @Binding var selectedFilterOption: FilterOptions
//    @Environment(\.presentationMode) var mode
//    @Binding var optSelected : Bool
//    
//    var body: some View {
//        VStack {
//            
//            Picker("\(placeholder)", selection: $selectedFilterOption) {
//                ForEach(FilterOptions.allCases, id: \.self) { option in
//                    Text(option.rawValue).tag(option)
//                }
//            }
//            .frame(maxWidth: .infinity)
//            
//            if selectedFilterOption == .date {
//                VStack {
//                    DatePickerView(placeholder: "Start Date", date: $startDate)
//                        .font(.subheadline)
//                    DatePickerView(placeholder: "End Date", date: $endDate)
//                        .font(.subheadline)
//                    Button {
//                        expenseTracker.getDateRange(startDate: startDate, endDate: endDate)
//                        expenseTracker.updateFiltering(selectedFilterOption)
//                        optSelected = true
//                    } label: {
//                        Text("Filter")
//                    }
//
//                }
//                .padding()
//            } else if selectedFilterOption == .amount {
//                VStack {
//                    Text("Start Amount")
//                    Text("End Amount")
//                }
//                .padding()
//            } else if selectedFilterOption == .category {
//                Picker("Select category", selection: $ctg) {
//                    ForEach(expenseTracker.categories, id: \.self) { ctg in
//                        Text("\(ctg.name)").tag(ctg.name)
//                    }
//                }
//                .frame(width: 350)
//                .onChange(of: ctg) { newValue in
//                    print("In on change")
//                    expenseTracker.selectedCategoryFilter = ctg
//                    expenseTracker.updateFiltering(.category)
//                    optSelected = true
//                    
//                }
//                
//            }
//            
//        }
//        .onChange(of: selectedFilterOption) { newValue in
//            if newValue == .none {
//                expenseTracker.updateFiltering(newValue)
//                optSelected = true
//            }
//        }
//    }
//}
//
//#Preview {
//    FilterPickerView(expenseTracker: ExpenseTrackerViewModel(), placeholder: "Filter picker", selectedFilterOption: .constant(.date), optSelected: Binding.constant(false))
//}
