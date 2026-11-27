# 📋 Flutter Practical Assessment - Submission Report

> **Candidate / Branch:** `anand_practicle_task`  
> **Environment:** Flutter `3.41.3` • Dart `3.11.1` • `flutter_bloc` `9.1.1`


## 📖 Overview of Implemented Scope

This repository contains the practical assessment task implementation for the **Kiosk Booking Application**. The objective of this assignment was to implement a responsive, robust, and clean Flutter solution supporting walk-in and appointment workflows with seamless adaptation across **Mobile** and **Tablet** form factors.

The codebase strictly adheres to the **BLoC (Business Logic Component)** pattern, separating UI, state handling, and data layers, with reusable shared UI components, centralized styling, and local mock JSON parsing.



## 🏛 Architecture & Key Technical Decisions

```
lib/
├── core/                       # Core utilities, theme, and constants
│   ├── constants/              # ColorConstants, TextStyleConstants, AppLabels
│   ├── theme/                  # Global ThemeData
│   └── utils/                  # SizeUtils (Breakpoints), NavigationUtils, Extensions
├── features/                   # Feature-Driven Modules
│   ├── auth/                   # [Task 1] Auth BLoC & Login UI
│   ├── home/                   # [Task 2] Home BLoC, Mobile & Tablet Views
│   ├── book_appointment/      # [Tasks 3, 4, 5] BLoC, Repository, Models, Screens, Widgets
│   └── splash/                 # Splash animation & redirection
└── shared/                     # Reusable UI Components
    └── widgets/                # AdaptiveSheet, PrimaryButton, CustomTextField, CommonAppBar
```

### 1. State Management: BLoC Pattern (`flutter_bloc`)
- Unidirectional data flow: UI dispatches `Events` $\rightarrow$ BLoC handles business logic $\rightarrow$ emits immutable `States` $\rightarrow$ UI rebuilds via `BlocBuilder` / `BlocConsumer`.
- Complete separation between UI components and business rules.

### 2. Responsiveness: Breakpoint-Driven Adaptive Layouts
- **Breakpoint**: Width `< 600px` (Mobile) vs. `>= 600px` (Tablet).

### 3. Repository & Datasource Pattern
- Local mock JSON data (`assets/json/services.json`) is accessed via `BookAppointmentDatasource` and abstracted through `BookAppointmentRepository`.
- Facilitates effortless migration to live REST APIs without modifying BLoC or UI logic.

---

## 📂 Summary of Code Deliverables (Files Implemented)

| Layer / Feature | File Path | Role in Assessment |
| :--- | :--- | :--- |
| **Auth** | `lib/features/auth/bloc/` | `auth_bloc.dart`, `auth_event.dart`, `auth_state.dart` |
| **Auth** | `lib/features/auth/screens/login_screen.dart` | Reactive login screen with validation |
| **Home** | `lib/features/home/bloc/` | `home_bloc.dart`, `home_event.dart`, `home_state.dart` |
| **Home** | `lib/features/home/screen/home_screen.dart` | View switcher & action listener |
| **Home** | `lib/features/home/widgets/home_mobile_view.dart` | Mobile stacked card layout |
| **Home** | `lib/features/home/widgets/home_tablet_view.dart` | Tablet side-by-side card layout |
| **Booking** | `lib/features/book_appointment/bloc/` | `book_appointment_bloc.dart`, events, and states |
| **Booking** | `lib/features/book_appointment/data/` | `book_appointment_datasource.dart`, `book_appointment_repo.dart` |
| **Booking** | `lib/features/book_appointment/model/` | `services_model.dart`, `service_professional_model.dart` |
| **Booking** | `lib/features/book_appointment/screens/` | `select_professionals_screen.dart`, `select_service_screen.dart`, `add_service_screen.dart` |
| **Booking** | `lib/features/book_appointment/widgets/` | `service_group_widget.dart`, `service_card_widget.dart`, `choose_service_card.dart`, `service_booking_card.dart` |
| **Shared** | `lib/shared/widgets/adaptive_sheet.dart` | Adaptive Modal Bottom Sheet (Mobile) vs. Slide Drawer (Tablet) |
| **Shared** | `lib/shared/widgets/` | `custom_text_field.dart`, `primary_button.dart`, `appbar_widget.dart` |
| **Core** | `lib/core/` | `color_constants.dart`, `text_style_constants.dart`, `size_utils.dart`, `navigation_utils.dart` |

---

## 🚀 How to Run and Evaluate the Assessment

### Prerequisites
- **Flutter SDK:** `3.41.3` (or `>= 3.0.0`)
- **Dart SDK:** `3.11.1` (or `>= 3.0.0 < 4.0.0`)
- Android Studio / VS Code 
- Android Emulator, Chrome, or physical device

### Steps to Run

1. **Clone the branch:**
   ```bash
   git clone -b anand_practicle_task <repository-url>
   cd kiosk-app-v4-assigment
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on Mobile Device / Emulator:**
   ```bash
   flutter run
   ```

4. **Run on Tablet / Widescreen Mode (Recommended for testing tablet layouts):**
   ```bash
   # Run in Chrome to freely resize window and observe mobile <-> tablet transitions:
   flutter run -d chrome

   ```




