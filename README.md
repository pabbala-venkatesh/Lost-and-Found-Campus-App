# 🎓 Campus Lost & Found App

A Flutter application designed to help students report, discover, and recover lost belongings on campus. The app uses Firebase to store item reports and manage user authentication.

## ✨ Features

- **Report items:** Submit details about lost or found belongings.
- **Browse reports:** View active item listings.
- **Item details:** View descriptions, locations, and reporter information.
- **Firebase Authentication:** Require users to sign in before reporting items.
- **Cloud Firestore:** Store and retrieve item reports.
- **Mark as Returned:** Allow the original reporter to update an item's status.
- **Access control:** Use Firestore Security Rules to protect item updates.
- **Responsive interface:** Build the user interface with Flutter for supported platforms.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | User interface and app development |
| Dart | Application programming language |
| Firebase Authentication | User sign-in |
| Cloud Firestore | Cloud database |
| Git | Version control |
| GitHub | Source code hosting |

## 📁 Project Structure

```text
lib/
├── models/
│   └── item_model.dart
├── screens/
│   ├── home_page.dart
│   ├── report_item_page.dart
│   ├── lost_items_page.dart
│   ├── found_items_page.dart
│   └── item_details_page.dart
└── services/
    ├── auth_service.dart
    └── firebase_service.dart
```

*The structure above represents the expected core files; adjust it if your current project differs.*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK (included with Flutter)
- Visual Studio Code or another Flutter-compatible IDE
- A Firebase project

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

4. Configure Firebase for your environment using the official Firebase Flutter setup guide.

5. Run the application:

   ```bash
   flutter run
   ```

### Run in Chrome

If web support is configured, launch the app with:

```bash
flutter run -d chrome
```

## 🔐 Security

- Users must authenticate before reporting items.
- Firestore Security Rules restrict status updates to the original reporter.
- Never commit service-account private keys or other sensitive credentials.
- Review the privacy implications of storing contact numbers in the database.

## 🧪 Testing

Check the following workflows before releasing the app:

- Sign in and report a lost item.
- Report a found item.
- Browse and open item details.
- Mark an item as returned using the original reporting account.
- Verify that another account cannot mark that item as returned.

## 🔮 Future Improvements

- Search by item name and campus location.
- Filter by Lost, Found, and Returned status.
- Add item photos.
- Improve accessibility and responsive layouts.
- Add a dedicated history of returned items.

## 👨‍💻 Author

**Project:** Campus Lost & Found App

**Developer:** Student project

Built to practise Flutter development, Firebase integration, database operations, and application access control.

## 📄 License

No license has been specified yet. Add a license if you intend to allow others to reuse or modify this project.
