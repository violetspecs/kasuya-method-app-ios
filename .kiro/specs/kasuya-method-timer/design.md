# Design

## Architecture
Single-screen SwiftUI app with a second timer screen pushed on navigation.

## Screens

### Main Screen (ContentView)
- Navigation title: "Timer"
- Coffee grams text field
- Acidity slider (1–5)
- Strength slider (1–5)
- Continuous mode toggle with description
- Start button

### Timer Screen
- Step indicator (e.g., "Pour 1 of 5")
- "Bloom" label for first pour
- Water amount for current pour
- Countdown timer with circular progress indicator
- Total water poured so far
- Start/Next Pour button (disabled while running)
- Skip button (visible only while timer is running)

## 4:6 Method Logic
- Total water = coffee grams × 15 (standard ratio)
- First 40% of water split across 2 pours (controls acidity)
- Remaining 60% split across 1-5 pours based on strength slider value (controls strength)
- Each pour interval: 45 seconds
- Continuous mode: automatically starts next pour when current pour completes
