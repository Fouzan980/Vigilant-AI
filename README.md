# Vigilant AI 


Vigilant AI is an AI-powered community safety platform. This monorepo contains the following components:

## Project Structure

- `flutter_app/`: Cross-platform mobile application built with Flutter.
- `mern/backend/`: Node.js/Express backend API with Firebase Admin SDK integration.
- `mern/command-center/`: React-based dashboard for real-time monitoring and analytics.
- `ai-model/`: FastAPI server for local AI model inference and verification.

## Prerequisites

- Flutter SDK
- Node.js & npm
- Docker & Docker Compose (optional for local deployment)

## Environment Configuration

All services use `.env` files for configuration. A master `.env` is located in the root directory. Ensure all sensitive keys (Firebase, AI APIs) are correctly populated.

## Local Development

### 1. Backend Server
```bash
cd mern/backend
npm install
npm run dev
```

### 2. Command Center (React)
```bash
cd mern/command-center
npm install
npm run dev
```

### 3. Flutter Application
```bash
cd flutter_app
flutter pub get
flutter run -d chrome # For web
# OR
flutter run -d <device_id> # For Android/iOS
```

### 4. AI Model Server
```bash
cd ai-model
pip install -r requirements.txt
uvicorn main:app --reload
```

## Docker Deployment

To launch the entire stack using Docker:
```bash
docker-compose up --build
```

## Architecture

- **Database**: Firebase Firestore (Production)
- **Authentication**: Firebase Auth (Google & Email/Password)
- **State Management**: Riverpod (Flutter), React Context (Dashboard)
- **Local Persistence**: SharedPreferences (Flutter Web compatibility)
