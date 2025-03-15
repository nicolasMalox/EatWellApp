# Flutter EatWell

## Description

Flutter EatWell is a mobile application designed to promote healthy eating by suggesting healthier versions of your favorite dishes. Utilizing advanced AI technology, the app allows users to chat with a virtual assistant named Gemini, which provides customized recipes based on the user's dietary preferences and restrictions.

## Features

- **Personalized Dietary Recommendations:** Users can receive meal suggestions that are tailored to their specific health requirements, including weight, height, and food allergies.
- **Interactive Chat Interface:** Engage with Gemini AI to explore new recipes and get answers to dietary questions.
- **User Profile Management:** Users can set and update their dietary preferences and personal health information to refine recipe suggestions.

## Technologies

- **Flutter:** Used for creating the UI and handling the application logic.
- **Riverpod:** Manages state and dependencies throughout the app.
- **Google Generative AI:** Powers the intelligent chat interactions with Gemini.
- **Flutter Dotenv:** Manages environment variables for safe app configuration.

## Libraries and Versions

- `cupertino_icons: ^1.0.8`
- `go_router: ^14.8.1`
- `hooks_riverpod: ^2.6.1`
- `google_generative_ai: ^0.4.6`
- `flutter_dotenv: ^5.2.1`
- `shared_preferences: ^2.5.2`
- `flutter_native_splash: ^2.4.4`
- `flutter_launcher_icons: ^0.14.3`

## 📂 **Project Structure**
The project follows a **clean architecture** approach, separating UI, business logic, and data.

lib/
│── features/
│   ├── chat/                    # Chat feature
│   │   ├── presentation/        # UI & Widgets
│   │   ├── providers/           # Riverpod state management
│   │   ├── models/              # Data models
│   ├── settings/                # User Settings feature
│── router.dart                   # App navigation with GoRouter
│── theme/                        # Global UI theme settings
│── main.dart                     # Entry point of the app

## Setup and Configuration

To run Flutter EatWell, ensure you have Flutter installed on your system. Clone the repository and install the dependencies by running:

```bash
flutter pub get
flutter run
```
## Important Note on API Keys

For practical reasons, this repository includes a `.env` file containing the API key for Gemini. **It is important to note that exposing API keys and sensitive data in public repositories is not recommended as it poses security risks.** However, for the ease of setup and demonstration purposes, it is included in this instance. In a production environment or in your projects, it is strongly advised to keep such keys private and manage them securely, for example, through environment variables on your deployment platform or encrypted secrets management services.

