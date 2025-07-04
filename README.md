## Preview
https://github.com/user-attachments/assets/ba60d967-7b16-4e17-958d-6a12cdc6b1ff

# Chat App

A modern, full-featured chat application built with *Flutter* and *Firebase*.

## Features

- *User Authentication*
  - Register with email and password
  - Login and logout securely
  - Password confirmation and error dialogs

- *Real-time Messaging*
  - Send and receive messages instantly using Firebase Firestore
  - Messages are displayed in a chat bubble UI
  - Automatic scrolling to the latest message
  - Sender's messages are aligned to the right, receiver's to the left

- *Theming*
  - Light and dark mode support
  - Custom color schemes using Flutter's ThemeData
  - Theme switching with Provider and ChangeNotifier

- *Navigation*
  - Drawer navigation with Home, Settings, and Logout options
  - Logout redirects to the login screen
  - Settings page for user preferences

- *UI Components*
  - Custom text fields and buttons for consistent design
  - Responsive layouts with proper padding and alignment
  - Animated scrolling and smooth transitions

- *Firebase Integration*
  - Uses firebase_core and cloud_firestore for backend
  - Secure authentication with firebase_auth
  - Real-time updates for chat messages

- *State Management*
  - Uses Provider for theme and app state management


## Getting Started

1. *Clone the repository*
2. *Install dependencies*
   
   flutter pub get
   
3. *Set up Firebase*
   - Add your google-services.json (Android) and GoogleService-Info.plist (iOS)
   - Configure your Firebase project as per firebase_options.dart

4. *Run the app*
   
   flutter run
   

## Folder Structure

- lib/pages/ — Main app pages (login, register, chat, settings)
- lib/components/ — Reusable UI widgets (drawer, buttons, text fields)
- lib/services/ — Authentication and chat services
- lib/theme/ — Theme data and provider

## Screenshots

(Add your screenshots here)

## Credits

- Built with [Flutter](https://flutter.dev/)
- Powered by [Firebase](https://firebase.google.com/)

---

*Enjoy chatting!*
