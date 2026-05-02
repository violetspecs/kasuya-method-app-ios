# Kasuya Method Timer v2

An iOS timer app for brewing coffee using the Kasuya 4:6 method.

## Features

- **Customizable Brew Parameters**
  - Coffee amount input (grams)
  - Acidity control (Sweet → Bright)
  - Strength control (Light → Strong)
  - Continuous mode for automatic pour progression

- **Guided Timer**
  - Step-by-step pour instructions
  - Bloom indicator for first pour
  - Circular countdown timer
  - Skip button to advance immediately
  - Total water tracking

- **4:6 Method Implementation**
  - First 40% of water split across 2 pours (controls acidity)
  - Remaining 60% split across 1-5 pours based on strength (controls strength)
  - 45-second intervals per pour
  - 15:1 water-to-coffee ratio

## Requirements

- iOS 15.6+
- Xcode 13.0+
- SwiftUI

## Installation

1. Clone the repository
2. Open `Kasuya Method Timer v2.xcodeproj` in Xcode
3. Build and run on your device or simulator

## Usage

1. Enter the amount of coffee in grams
2. Adjust acidity slider (1-5)
3. Adjust strength slider (1-5) to set number of pours
4. Optionally enable continuous mode
5. Tap "Start" to begin brewing
6. Follow the guided pour instructions

## License

MIT
