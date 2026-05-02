# Requirements

## Overview
An iOS timer app implementing the Kasuya (4:6) coffee brewing method, allowing users to customize brew parameters and follow a guided pour sequence.

## Requirements

### R1 - Brew Configuration
- User can input the amount of coffee in grams
- User can select acidity level (1–5): Sweet, Somewhat Sweet, Balanced, Somewhat Bright, Bright
- User can select strength level (1–5): Light, Somewhat Light, Balanced, Somewhat Strong, Strong
  - Strength level determines number of pours for the 60% portion (1→1, 2→2, 3→3, 4→4, 5→5)
- User can enable continuous mode to automatically start the next pour without pressing a button

### R2 - Timer
- App calculates water amounts and pour timings based on the 4:6 method and user inputs
- Start button begins the guided timer sequence
- Timer guides the user through each pour step
- First pour is labeled as "Bloom"
- Skip button allows user to immediately advance to the next pour
- In continuous mode, timer automatically advances to next pour without user interaction

### R3 - Platform
- Target: iOS 15.6+
- Built with SwiftUI
