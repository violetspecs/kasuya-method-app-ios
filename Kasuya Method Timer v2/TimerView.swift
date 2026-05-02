//
//  TimerView.swift
//  Kasuya Method Timer v2
//

import SwiftUI

struct TimerView: View {
    let plan: BrewPlan
    let continuous: Bool
    @Environment(\.presentationMode) var presentationMode

    @State private var currentStep = 0
    @State private var secondsLeft = 0
    @State private var timer: Timer? = nil
    @State private var isRunning = false
    @State private var isDone = false

    private var step: BrewStep { plan.steps[currentStep] }
    private var totalPoured: Double {
        plan.steps.prefix(currentStep).reduce(0) { $0 + $1.waterAmount }
    }

    var body: some View {
        VStack(spacing: 32) {
            if isDone {
                doneView
            } else {
                stepView
            }
        }
        .padding()
        .navigationTitle("Brewing")
        .navigationBarBackButtonHidden(isRunning)
        .onDisappear { timer?.invalidate() }
    }

    // MARK: - Step View

    private var stepView: some View {
        VStack(spacing: 32) {
            VStack(spacing: 4) {
                Text("Pour \(currentStep + 1) of \(plan.steps.count)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                if currentStep == 0 {
                    Text("Bloom")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            VStack(spacing: 8) {
                Text("\(Int(step.waterAmount.rounded()))g")
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                Text("of water")
                    .foregroundColor(.secondary)
            }

            Text("Total poured: \(Int(totalPoured.rounded()))g / \(Int(plan.totalWater.rounded()))g")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ZStack {
                Circle()
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 8)
                Circle()
                    .trim(from: 0, to: isRunning ? CGFloat(secondsLeft) / CGFloat(step.intervalSeconds) : 1)
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: secondsLeft)
                Text(isRunning ? "\(secondsLeft)s" : "Ready")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
            }
            .frame(width: 160, height: 160)

            Button(action: startStep) {
                Text(isRunning ? "Running…" : (currentStep == 0 ? "Start" : "Next Pour"))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isRunning ? Color.secondary : Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(isRunning)

            if isRunning {
                Button(action: skipStep) {
                    Text("Skip")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
    }

    // MARK: - Done View

    private var doneView: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            Text("Brew Complete!")
                .font(.title.bold())
            Text("Total water used: \(Int(plan.totalWater.rounded()))g")
                .foregroundColor(.secondary)
            Button("Done") { presentationMode.wrappedValue.dismiss() }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }

    // MARK: - Logic

    private func startStep() {
        secondsLeft = step.intervalSeconds
        isRunning = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if secondsLeft > 1 {
                secondsLeft -= 1
            } else {
                timer?.invalidate()
                isRunning = false
                advance()
            }
        }
    }

    private func skipStep() {
        timer?.invalidate()
        isRunning = false
        advance()
    }

    private func advance() {
        if currentStep + 1 < plan.steps.count {
            currentStep += 1
            if continuous {
                startStep()
            }
        } else {
            isDone = true
        }
    }
}
