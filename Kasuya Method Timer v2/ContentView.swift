//
//  ContentView.swift
//  Kasuya Method Timer v2
//
//  Created by Martin on 1/28/26.
//

import SwiftUI

struct ContentView: View {
    @State private var coffeeGrams: String = ""
    @State private var acidity: Int = 3
    @State private var strength: Int = 3
    @State private var continuous: Bool = false
    @State private var brewPlan: BrewPlan? = nil
    @State private var showValidationError = false

    let acidityLabels = ["Sweet", "Somewhat Sweet", "Balanced", "Somewhat Bright", "Bright"]
    let strengthLabels = ["Light", "Somewhat Light", "Balanced", "Somewhat Strong", "Strong"]

    private var parsedGrams: Double? {
        guard let value = Double(coffeeGrams), value > 0 else { return nil }
        return value
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text("Coffee")) {
                        TextField("Amount of coffee (grams)", text: $coffeeGrams)
                            .keyboardType(.decimalPad)
                        if showValidationError && parsedGrams == nil {
                            Text("Enter a valid amount greater than 0")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }

                    Section(header: Text("Acidity — \(acidityLabels[acidity - 1])")) {
                        StepSlider(value: $acidity, steps: 5)
                    }

                    Section(header: Text("Strength — \(strengthLabels[strength - 1])")) {
                        StepSlider(value: $strength, steps: 5)
                    }

                    Section {
                        Toggle("Continuous Mode", isOn: $continuous)
                    } footer: {
                        Text("Automatically start the next pour without pressing a button")
                    }
                }

                NavigationLink(
                    destination: brewPlan.map { TimerView(plan: $0, continuous: continuous) },
                    isActive: Binding(
                        get: { brewPlan != nil },
                        set: { if !$0 { brewPlan = nil } }
                    )
                ) { EmptyView() }

                Button(action: startBrew) {
                    Text("Start")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()
                .background(Color(UIColor.systemBackground))
            }
            .navigationTitle("Timer")
        }
        .navigationViewStyle(.stack)
    }

    private func startBrew() {
        showValidationError = true
        guard let grams = parsedGrams else { return }
        brewPlan = calculateBrewPlan(coffeeGrams: grams, acidity: acidity, strength: strength)
    }
}

struct StepSlider: View {
    @Binding var value: Int
    let steps: Int

    var body: some View {
        HStack {
            Text("1").foregroundColor(.secondary).font(.caption)
            Slider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int($0.rounded()) }
                ),
                in: 1...Double(steps),
                step: 1
            )
            Text("\(steps)").foregroundColor(.secondary).font(.caption)
        }
    }
}

#Preview {
    ContentView()
}
