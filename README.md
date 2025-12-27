# Laza – E-commerce Mobile App (Flutter)

## 📱 Project Overview
**Project Name:** Laza – E-commerce Mobile App  
**Platform:** Android & iOS  
**Framework:** Flutter (Single Codebase)  
**Backend:** Firebase (Authentication & Firestore)  
**API:** Platzi Fake Store API  

This project is a simplified e-commerce MVP based on the *Laza UI Kit*.  
It allows users to browse products, manage cart and favorites, and perform a mock checkout.

---

## 🎯 Features Implemented
- Firebase Authentication (Email & Password)
- Auto-login & Logout
- Product listing from API
- Product details screen
- Add / remove from cart
- Add / remove favorites
- Cart persistence using Firestore
- Mock checkout with success screen
- Profile screen (email + logout)
- Error handling & empty states

---

## 🧩 Tech Stack
- **Flutter**
- **Firebase Authentication**
- **Cloud Firestore**
- **Platzi Fake Store API**
- **Appium (End-to-End Testing)**
- **Node.js**

---

## 📂 Project Structure




---

## 🔐 Firebase Setup
1. Create a Firebase project
2. Enable **Email/Password Authentication**
3. Create Firestore database
4. Add Android & iOS apps
5. Download:
   - `google-services.json`
   - `GoogleService-Info.plist`
6. Run:
```bash
flutterfire configure


📦 Firestore Structure
users/{uid}
carts/{uid}/items/{productId}
favorites/{uid}/items/{productId}


▶️ Run the App
flutter pub get
flutter run

🧪 Appium Tests
Requirements

Node.js

Appium Server

Android SDK

Real device or emulator
🧪 Appium Test
npm install webdriverio
node appium_tests/auth_test.js
node appium_tests/cart_test.js

🧪 Test Coverage

Auth Test: Signup & Login → Home

Cart Test: Add product → Open cart → Validate item

