//
//  ContentView.swift
//  WeSplit
//
//  Created by Rahul Shah on 05/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPreople: Int = 1
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let people: Double = Double(numberOfPreople + 2)
        let tip: Double = Double(tipPercentage)
        let tipValue: Double = checkAmount / 100 * tip
        let total = checkAmount + tipValue
        let amountPerPerson = total/people
        return amountPerPerson
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPreople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section {
                    Text("\(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) / person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
