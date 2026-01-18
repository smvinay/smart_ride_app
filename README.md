🚕 Smart Ride – Flutter Ride Booking & Trip Management App

A cross-platform Flutter application that simulates a real-time ride booking platform (similar to Uber / Ola).
This project demonstrates clean architecture, state management, real-time UI updates, offline storage, and testable business logic.

Built as part of a Flutter Developer Technical Assignment.

📌 Project Highlights

Real-time ride lifecycle simulation
Offline-first data storage
Reactive dashboard with live analytics
Clean, modular Flutter architecture
Fully testable business logic
Smooth UI/UX with animations

📱 Features
1️⃣ Dashboard

Total completed trips
Total amount spent
Active ride summary (if any)
Trips grouped by ride type (Pie chart)
Monthly spending limits with visual indicators
Pull-to-refresh support
Live updates without app restart

2️⃣ Trip Booking (CRUD)

Add, edit, delete trips
Fields:
Pickup location
Drop location
Ride type (Mini, Sedan, Auto, Bike)
Fare amount
Date & time
Input validation and error handling
delete support

3️⃣ Book Now vs Scheduled Rides

Book Now

Starts ride simulation immediately
Scheduled Rides
Future date & time selection
Remain in Scheduled state
Do not auto-start simulation
Can be edited or cancelled

4️⃣ Real-Time Ride Simulation

Ride progresses automatically:
Requested → Driver Assigned → Ride Started → Completed


Implemented using:

Timer
Riverpod StateNotifier
No manual refresh required
UI updates reactively on every state change

5️⃣ Live Fare Updates

Fare increases during ride
Updates every few seconds
Animated UI updates
Stops automatically when ride completes or cancels

6️⃣ Driver Tracking (Mocked)

Simulated driver movement
ETA countdown
Simple animated route indicator
No maps required (UI-focused simulation)

7️⃣ In-App Notifications

Snackbar notifications triggered by state changes:
Driver assigned
Ride started
Ride completed
Ride cancelled
No manual triggers
State-driven only

8️⃣ Active Ride Handling

Active ride card shown on dashboard
Quick navigation to live status screen
Analytics hidden while ride is active
Seamless return to dashboard after completion

9️⃣ Analytics & Spending Limits

Trips grouped by ride type
Monthly spending tracking
Visual indicators:
🟢 Under limit
🟡 Near limit
🔴 Over limit

Recalculated live after every ride

🔟 CSV Export

Export full trip history to CSV

Includes:
Pickup
Drop
Ride type
Fare
Status
Date & time
Share via system share sheet

🌗 UI / UX Enhancements

Light / Dark mode toggle
Smooth animations:
Status transitions
Fare updates
Driver movement
Clean card-based UI
Responsive mobile layout

🧱 Architecture
lib/
├── models/        → Hive data models
├── state/         → Riverpod providers & StateNotifiers
├── screens/       → App screens (UI)
├── widgets/       → Reusable UI components
├── utils/         → CSV export, helpers
└── core/          → Constants & shared configs

Design Principles

Separation of concerns
Business logic isolated from UI
Predictable state updates
Easy testability

🧠 State Management

Riverpod (StateNotifier)
Centralized business logic
Reactive UI updates
Clean dependency injection
Scalable and test-friendly

💾 Offline Storage

Hive

Fast local persistence
Works without internet

Used for:
Trips
Status updates
Fare updates

🔁 Real-Time Update Strategy

Ride lifecycle simulated using Timer

Fare updates via periodic timers

UI listens to provider state

No polling

No manual refresh

Fully reactive architecture

🧪 Testing
Test Coverage
Trip CRUD operations
Ride status transitions
Scheduled ride behavior
Dashboard live calculations
Tools Used
flutter_test
Hive test setup with isolated storage
Key Testing Focus
Business logic correctness
State transition reliability
No UI-coupled logic

🚀 Getting Started
Prerequisites
Flutter 3.x+
Dart SDK

Android Studio / VS Code

Installation
git clone https://github.com/smvinay/smart_ride_app.git
cd smart_ride_app
flutter pub get
flutter run

Running Tests
flutter test

📦 Tech Stack

Flutter
Dart
Riverpod
Hive
FL Chart
Intl
UUID

