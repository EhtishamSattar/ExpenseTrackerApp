//
//  UserDefaultsManager.swift
//  ExpenseTrackerApp
//
//  Created by Mac on 27/08/2024.
//

import Foundation

enum UserDefaultsKeys : String, CaseIterable {
    case userDefaultsKey = "expenseTrackerData"
}

class UserDefaultsManager{

    //Shared Instance
    static let shared = UserDefaultsManager()
    
    //To make the class Singleton
    private init() { }
    
    
    func loadData() -> ExpenseTrackerData{
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.userDefaultsKey.rawValue) {
            let decoder = JSONDecoder()
            do {
                let expenseTrackerData = try decoder.decode(ExpenseTrackerData.self, from: data)
                return expenseTrackerData
            } catch {
                print("Failed to decode expense tracker data: \(error)")
            }
        }
        return ExpenseTrackerData()
    }
    
    //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////
   
    func loadDataSecondWay() -> ExpenseTrackerData?{
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.userDefaultsKey.rawValue) {
            let decoder = JSONDecoder()
            do {
                let expenseTrackerData = try decoder.decode(ExpenseTrackerData.self, from: data)
                return expenseTrackerData

            } catch {
                print("Failed to decode expense tracker data: \(error)")
            }
        }
        return nil
    }
    //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////   //////////////////////
    
    func saveData(expenses: [Expense], categories: [Category]) {
        let encoder = JSONEncoder()
        let expenseTrackerData = ExpenseTrackerData(expenses: expenses, categories: categories)
        do {
            let encodedData = try encoder.encode(expenseTrackerData)
            UserDefaults.standard.set(encodedData, forKey: UserDefaultsKeys.userDefaultsKey.rawValue)
        } catch {
            print("Failed to encode expense tracker data: \(error)")
        }
    }
}

//MARK: - For category managing
extension UserDefaultsManager{
    
}
