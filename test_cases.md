# Appium Test Cases

## Test Case 1: Authentication Test
**Pre-conditions**
- App installed on Android device
- Appium server running
- Valid internet connection

**Steps**
1. Launch the app
2. Tap on Sign Up / Login
3. Enter email and password
4. Submit login form

**Expected Result**
- User is successfully authenticated
- Home screen is displayed

---

## Test Case 2: Cart Test
**Pre-conditions**
- User is logged in
- Products are loaded from API

**Steps**
1. Open a product from Home screen
2. Add product to cart
3. Open Cart screen

**Expected Result**
- Product appears in cart successfully

---

## Tools & Versions
- Appium: v3.x
- Node.js: v22.x
- Android Device: Real device
