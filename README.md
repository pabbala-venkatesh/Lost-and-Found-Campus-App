# Campus Lost & Found App

A Flutter-based web application that helps campus users report, browse, and manage lost and found items.

**Live Demo:** https://campus-lost-found-app-a43fe.web.app  
**GitHub Repository:** https://github.com/pabbala-venkatesh/Lost-and-Found-Campus-App

## About the Project

The Campus Lost & Found App provides a central place for students and campus users to report missing belongings and browse items that have been found. The goal is to make it easier to reconnect people with their lost belongings through a simple, user-friendly interface.

## Features

- **Report Lost or Found Items:** Submit reports with item details.
- **Browse Items:** View lost and found item listings.
- **Search Items:** Find reports more conveniently.
- **View Item Details:** Open individual reports for additional information.
- **Firebase Integration:** Uses Firebase services for application backend functionality.
- **Item Status Management:** Supports marking eligible reports as returned.
- **Responsive Interface:** Designed to work on desktop, tablet, and mobile screens.
- **Web Deployment:** Published online using Firebase Hosting.

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | User interface and application development |
| Dart | Application programming language |
| Firebase Authentication | User authentication |
| Cloud Firestore | Cloud database for item reports |
| Firebase Hosting | Web application deployment |
| Git and GitHub | Version control and source code management |

## Getting Started

### Prerequisites

Install the following tools:

- Flutter SDK
- Dart SDK (included with Flutter)
- Git
- Visual Studio Code with the Flutter and Dart extensions
- A Firebase project configured for the application

### Installation

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

4. Run the application:

   ```bash
   flutter run
   ```

For web development, use:

```bash
flutter run -d chrome
```

Firebase configuration and enabled services must be set up correctly for authentication and database features to work.

## Firebase Configuration

The application uses Firebase for authentication and item data storage.

To run your own configured copy:

1. Create or select a Firebase project.
2. Register the required Flutter platform applications.
3. Configure Firebase for Flutter using the FlutterFire CLI.
4. Ensure the Firebase Authentication provider and Cloud Firestore database are configured.
5. Set up and test Firestore security rules before using real user data.

Do not commit service-account credentials, private keys, passwords, or other secrets to GitHub.

## Project Structure

```text
campus_lost_found/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── screens/
│   │   ├── report_item_page.dart
│   │   ├── lost_items_page.dart
│   │   ├── found_items_page.dart
│   │   └── item_details_page.dart
│   └── services/
│       └── firebase_service.dart
├── test/
├── web/
├── pubspec.yaml
└── README.md
```

*Note: The structure above describes the expected main files; adjust it if your current repository differs.*

## Security and Privacy

Security is important when handling campus lost-and-found reports.

- Require authentication for report creation and other restricted operations.
- Apply Firestore rules to validate ownership and allowed updates.
- Avoid storing private contact details in publicly readable documents.
- Use sample data when demonstrating the application publicly.
- Review Firebase security rules before inviting real users.

**Privacy note:** The current Firestore configuration may expose reporter names and phone numbers because item documents are publicly readable. Separate private contact information and update the security rules before using the application with real users.

## Future Improvements

- Separate public item details from private contact information.
- Add item image uploads.
- Improve search with category and location filters.
- Add notifications when matching items are reported.
- Improve accessibility and user experience.
- Expand automated tests for authentication, reporting, and item status updates.

## Learning Outcomes

This project provides practical experience with:

- Flutter and Dart application development.
- Building responsive interfaces.
- Integrating Firebase services.
- Working with cloud database rules and authentication.
- Using Git and GitHub for version control.
- Building and deploying a Flutter web application.

## Author

**Campus Lost & Found App**  
Developed as a learning project to explore Flutter, Firebase, and practical application development.

- **Live Demo:** https://campus-lost-found-app-a43fe.web.app
- **Source Code:** https://github.com/pabbala-venkatesh/Lost-and-Found-Campus-App
