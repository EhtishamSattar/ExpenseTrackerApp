//
//  ExpenseTracker.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 22/08/2024.
//

import SwiftUI

struct ExpenseTracker: View {

    @StateObject var expenseTracker : ExpenseTrackerViewModel = ExpenseTrackerViewModel()
    
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "ThemeColor")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "ThemeColor") ?? UIColor.black]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView{
            
            TabView {
                HomeView(expenseTracker: expenseTracker)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                CategoryView(expenseTracker: expenseTracker)
                    .tabItem {
                        Label("Category", systemImage: "list.bullet")
                        
                    }
            }
        }
        
    }
}

#Preview {
    ExpenseTracker()
}
