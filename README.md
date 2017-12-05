BloodPressureForEveryone
========================

## Table of Contents

1. [Overview](#overview)
2. [Release Notes](#release-notes)
3. [Install Guide](#install-guide)
4. [Build Guide](#build-guide)
5. [Troubleshooting](#troubleshooting)

## Overview

BloodPressureForEveryone is a two-edition HIPAA-compliant iOS application, one for medical professionals (BPForProfessionals) and the other for caretakers (BPForEveryone), that allows users to analyze blood pressure measurements. The latter allows users to track and view their blood pressure history. Additionally, the application also provides supplementary resources for specialists and common practitioners alike and educational resources for patients and caregivers.

## Release Notes
> ## v1.0.0 (12/04/2017)
> 
> ### New Features:
> Application interpretations, data models, and data visualizations are now based off of the [Clinical Practice Guideline for Screening and Management of High Blood Pressure in Children and Adolescents](http://pediatrics.aappublications.org/content/early/2017/08/21/peds.2017-1904), the latest of its kind published by the American Academy of Pediatrics (AAP).
> 
> #### BPForProfessionals:
> - Patient data can be entered to obtain a blood pressure measurement analysis
> - Graph view displays patient plot in comparison to blood pressure norms
> - Resources tab provides articles, journal papers, websites, and other miscellaneous tools
>
> #### BPForEveryone:
> - Patient data and a comprehensive patient profile can be entered and saved to obtain a blood pressure measurement analysis
> - Past patient blood pressure measurements can be viewed as a list history
> - Graph view displays past blood pressure measurements as a plot over time
> - Resources tab provides articles, websites, programs, and other miscellaneous tools to help educate the user about blood pressure, hypertension, cardiovascular health, and eating and exercise habits
>
> #### Bug Fixes:
> - Corrected errors in BP Norms tables for 13 year olds.
> - Corrected BPForEveryone View that reveresed systolic and diastolic blood pressures
>
> #### Known Bugs and Defects:
> - *Crash*: In certain circumstances on both applications, if patient data is entered incorrectly, the analysis will not proceed and there will be a fatal error.

## Install Guide

### Prerequisites
- iOS 11.0 or later

### Beta Install
- Connect iPhone to a computer with iTunes.
- Drag & Drop the BPForEveryone.ipa or BPForProfessionals.ipa to the phone to sync.

### Official Download and Installation (Coming Soon)
- Navigate to the App Store to find and download our application
- Installation will begin on your device when the application finishes downloading

## Build Guide

### Build Requirements
- macOS 10.12 Sierra or later
- Xcode 9.0 (iOS 11.0 SDK) or later
- Swift 4.0 or later

### Dependencies
The following are required to render the graph views in the app:
- [CocoaPods Dependency Manager](https://cocoapods.org/)
- [Core Plot 2D Plotting Framework for iOS](https://github.com/core-plot/core-plot)

### Build Instructions
- After cloning the project navigate to the project directory and run
```bash
pod install
```
- Open project BPApp.xcworkspace in XCode.
- Select the desired target application and device and select 'build'
