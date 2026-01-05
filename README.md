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
To run this project, you need to initialize the native platforms with your own Firebase configuration.

1. General Requirements
Flutter SDK (Latest Stable)
A Firebase Project created in the Firebase Console.

2. Android Initialization
Register App: Add an Android app to your Firebase project using the package name
Config File: Download google-services.json and place it in android/app/.
Run the following in your terminal:
cd android
./gradlew clean

4. iOS Initialization
Register App: Add an iOS app to your Firebase project using your Bundle ID.
Config File: Download GoogleService-Info.plist and move it into ios/Runner/ using Xcode.
Permissions: Add location and notification descriptions to ios/Runner/Info.plist.
CocoaPods: Run the following in your terminal:
cd ios
pod install

5. Run the Project
flutter pub get
flutter run

lib/
├── core/          # FirebaseService, AppTheme, and Constants
├── providers/     # Riverpod State Providers
├── models/        # Task and User Data Models
├── screens/       # UI Screens (Home, Profile, Details, Login)
└── widgets/       # Custom reusable components
