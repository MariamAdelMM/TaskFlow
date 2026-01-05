🚀 TaskFlow
===========================
TaskFlow is a professional-grade task management application built with Flutter. It focuses on clean architecture, fluid animations, and real-time synchronization. From state management with Riverpod to real-time messaging via Firebase.

🎨 Design & UI
===========================
The interface was designed using Stitch to ensure a modern, user-centric experience.
UI Prototype: View on LinkedIn/Stitch.

Theming: Full support for high-contrast Dark Mode and custom typography.

Animations: Explicit animations for the Splash Screen and smooth transitions between task states.


🛠️ Technical Implementation
===========================
State & Persistence
State Management: Implemented Riverpod for predictable state transitions and decoupled logic.

Local Storage: Used SharedPreferences for persisting user sessions and authentication data.

Interactions: Integrated Dismissible widgets for intuitive swipe-to-delete actions.

Firebase Integration
Messaging: Uses Firebase In-App Messaging for real-time user engagement.

Analytics: Tracks user interaction patterns to improve UX flow.

🚀 Setup & Initialization
===========================

This guide walks you through setting up **TaskFlow** locally from scratch.

## 1️⃣ Prerequisites

Make sure the following tools are installed and properly configured:

* **Flutter SDK** (latest stable)

  ```bash
  flutter --version
  ```

* **Dart SDK** (included with Flutter)

* **Android Studio** (Android SDK & Emulator)

* **Xcode** (latest version, for iOS development)

* **CocoaPods** (for iOS dependencies)

  ```bash
  sudo gem install cocoapods
  ```

Verify your environment:

```bash
flutter doctor
```

---

## 2️⃣ Clone the Repository

```bash
git clone git@github.com:MariamAdelMM/TaskFlow.git
cd taskflow
```

---

## 3️⃣ Install Flutter Dependencies

```bash
flutter pub get
```

---

## 4️⃣ Android Initialization

```bash
cd android
./gradlew clean
cd ..
```

---

## 5️⃣ iOS Initialization

```bash
cd ios
pod install
cd ..
```
---
## 6️⃣ Run the Project
```bash
flutter run
```
