# Campus Lost & Found App

A Flutter-based application designed to help college students report lost and found items, search for belongings, and view item details in one place.

## Problem Statement

Students often struggle to recover belongings misplaced around campus. This project aims to provide a simple, centralized platform to make reporting and finding items easier.

## Features

- Report lost items with a name, description, and location
- Report found items
- Select whether an item is lost or found
- Search reported items by name, location, or description
- Browse lost and found item lists
- View individual item details
- Display recent reports on the home screen
- Validate required fields before submitting a report

## Technologies Used

- **Flutter** — application UI and development
- **Dart** — programming language
- **Git** — version control
- **GitHub** — source code hosting

**Planned technology:** Firebase for persistent data storage.

## Current Project Status

The main screens, reporting form, search functionality, item lists, and item details navigation are implemented. The project passes Flutter static analysis and its current automated tests.

At present, newly reported items are stored in temporary in-memory storage. They do not persist after the application restarts.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK (included with Flutter)
- Visual Studio Code or another compatible IDE
- Google Chrome for running the web version

### Run Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/pabbala-venkatesh/Lost-and-Found-Campus-App.git
   ```

2. Open the project directory:

   ```bash
   cd Lost-and-Found-Campus-App
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application in Chrome:

   ```bash
   flutter run -d chrome
   ```

5. Check code quality:

   ```bash
   flutter analyze
   ```

6. Run automated tests:

   ```bash
   flutter test
   ```

## Future Improvements

- Integrate Firebase Cloud Firestore for persistent item storage
- Add user authentication
- Implement contact details or secure communication between students
- Add functionality to mark items as returned
- Add item images and filters
- Improve automated tests for reporting and searching

## Author

Developed as a student project to practise Flutter, Dart, UI development, and version control.
