//
//  BrewCalculator.swift
//  Kasuya Method Timer v2
//

import Foundation

struct BrewStep {
    let pourNumber: Int
    let waterAmount: Double  // grams
    let intervalSeconds: Int
}

struct BrewPlan {
    let steps: [BrewStep]
    let totalWater: Double
}

/// Calculates pour steps using the Kasuya 4:6 method.
/// - First 40% of water: 2 pours controlling acidity
/// - Remaining 60%: 3-7 pours controlling strength (based on strength slider)
/// - Each pour interval: 45 seconds
func calculateBrewPlan(coffeeGrams: Double, acidity: Int, strength: Int) -> BrewPlan {
    let totalWater = coffeeGrams * 15
    let firstPart = totalWater * 0.4   // controls acidity
    let secondPart = totalWater * 0.6  // controls strength

    // Acidity: split firstPart into 2 pours
    // acidity 1 (sweet) = larger first pour; acidity 5 (acidic) = more equal split
    let acidityRatio = 0.3 + Double(acidity - 1) * 0.1  // 0.3 ... 0.7
    let pour1 = firstPart * acidityRatio
    let pour2 = firstPart * (1 - acidityRatio)

    // Strength: map slider value to number of pours (1→1, 2→2, 3→3, 4→4, 5→5)
    let strengthPours = strength
    let perPour = secondPart / Double(strengthPours)

    var steps: [BrewStep] = [
        BrewStep(pourNumber: 1, waterAmount: pour1, intervalSeconds: 45),
        BrewStep(pourNumber: 2, waterAmount: pour2, intervalSeconds: 45),
    ]
    for i in 0..<strengthPours {
        steps.append(BrewStep(pourNumber: 3 + i, waterAmount: perPour, intervalSeconds: 45))
    }

    return BrewPlan(steps: steps, totalWater: totalWater)
}
