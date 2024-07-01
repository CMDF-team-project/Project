# Mood Tracker App

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Screenshots](#screenshots)
4. [Installation](#installation)
5. [Setup](#setup)
6. [Usage](#usage)
7. [Code Structure](#code-structure)
8. [Contacts](#contact)

## Introduction

Mood Tracker is a Flutter application that helps users to record and monitor their moods daily. The app integrates with Firebase to store mood data and supports both light and dark themes.

## Features

- Record daily moods with optional text descriptions.
- View mood entries on a calendar.
- Toggle between light and dark themes.
- Firebase integration for storing and retrieving mood data.

## Screenshots

### Splash Screen GIF

### Home Screen

Home Screen. Light Theme

![Home Screen. Light Theme](screenshots/photo_2024-07-01_17-31-48.jpg)

Home Screen. Dark Theme

![Home Screen. Dark Theme](screenshots/photo_2024-07-01_17-31-41.jpg)

### Mood Input Screen

First View on Mood Input Screen

![First View on Mood Input Screen](screenshots/photo_2024-07-01_17-31-40.jpg)

Types of Mood

![Types of Mood](screenshots/photo_2024-07-01_17-31-40%20(2).jpg)

### Mood Input Screen Warnings

Data on this day is already exists

![Data on this day is already exists](screenshots/photo_2024-07-01_17-31-40%20(3).jpg)

Mood is not selected

![Mood is not selected](screenshots/photo_2024-07-01_17-31-40%20(4).jpg)

## Installation

### Prerequirements

Before you begin, ensure you have met the following requirements:
- You have installed Flutter on your local machine. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- You have a code editor like VSCode or Android Studio.
- You have an Android or iOS device/emulator to run the project.

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/your-repository.git
   ```

2. **Navigate to the progect directory.**
    ```bash
    cd Project
    ```
3. **Install dependencies**
    ```bash
    flutter pub get
    ```
## Setup

### Android

1. Open the project in Android Studio.
2. Make sure you have an Android emulator set up, or connect your Android device via USB.
3. Set up an Android virtual device (AVD) if you don't have one.

### IOS

1. Open the project in Xcode.
2. Make sure you have an iOS simulator set up, or connect your iOS device via USB.
3. Ensure that you have the necessary permissions and certificates to run the app on your iOS device.

### Firebase

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project or select an existing project.
3. Add an Android app to your Firebase project.
4. Add an iOS app to your Firebase project.

## Usage

1. **Running the app on an Android/IOS device/emulator:**
    ```bash
    flutter run
    ```
    Alternatively, you can press the "Run" button in Android Studio.
    Alternatively, you can press the "Run" button in Xcode.
2. **Building an APK for Android:**
    ```bash
    flutter build apk
    ```
    The generated APK file will be located in the build/app/outputs/flutter-apk/ directory.
3. **Building an iOS app:**
    ```bash
    flutter build ios
    ```
    Open the iOS project in Xcode and run it on your device.

### Recording a Mood
- Open the app. After 4 seconds of Splash Screen you will be transfered to the Home Screen.
- Select "plus" button in the bottom right corner.
- Select a mood and write a description.
- Select "Save Mood" button.

### Togling Themes
- Tap the theme toggle button (sun icon) on the app bar to switch between light and dark themes.

## Code Structure
- 'main.dart': Entry point of the application.
- 'provider.dart': Contains the business logic for handling mood data.
- 'screens' and 'additional_screens': Contains the UI screens of the application.
- 'dialogue/mood_dialogue.dart': Contains a dialog to show mood data in the calendar on the Home Screen.
- 'custom painter': Contains custom paint object for the Splash Screen. 
- 'connectivity': Contains the logic dealing with changes in connection with the Internet.

## Contact

If you have any questions or suggestions, feel free to reach out to one of the team members at e.zagurskih@innopolis.university, o.novoselova@innopolis.university.
