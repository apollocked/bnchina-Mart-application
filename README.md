# 🛒 Mini Mart - Premium Flutter E-Commerce Experience

[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue.svg?logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Mini Mart is a sophisticated, feature-rich mobile e-commerce application built with Flutter. It delivers a seamless shopping experience with a focus on rich aesthetics, high performance, and robust state management.

---

## ✨ Core Features

### 🔐 Secure Authentication & Identity
- **Full Auth Flow** - Robust registration and login systems with real-time validation.
- **Session Persistence** - Automatic user session management via encrypted local storage.
- **Profile Security** - Secure password update workflows and secondary confirmation for account deletion.
- **Dynamic Avatars** - Custom profile photo uploads with local persistence.

### 🏪 Discovery & Shopping
- **Intuitive Navigation** - Category-based filtering and trending products carousels.
- **Rich Product Detail** - Beautifully designed product pages with complete specifications.
- **Smart Basket Management** - Real-time quantity updates, swipe-to-remove, and a dedicated "Clear Basket" functionality.
- **Location Awareness** - Precision location tracking displayed in the primary interface.

### 🎟️ Advanced Promotions & Orders
- **Multi-Coupon System** - Sophisticated validation logic for instant discount applications.
- **Order Tracking** - Detailed purchase history with unique Order IDs and high-precision timestamps.
- **Instant Notifications** - Live notification system with badge tracking for purchases and promotions.

---

## 🛠️ Technology Stack

| Category | Technology | Usage |
|----------|------------|-------|
| **Core** | [Flutter](https://flutter.dev) | UI Framework & Mobile Development |
| **Logic** | [Dart](https://dart.dev) | Primary Programming Language |
| **Persistence**| [shared_preferences](https://pub.dev/packages/shared_preferences) | Local JSON Data Serialization |
| **Icons** | [Font Awesome](https://pub.dev/packages/font_awesome_flutter) | High-resolution Iconography |
| **Utility** | [shortid](https://pub.dev/packages/shortid) | Unique ID Generation for Orders |
| **Branding** | SVG & PNG | Custom Assets & Thematic Components |

---

## 🏗️ Project Architecture

The application follows a **Modular Service-Oriented Architecture** to ensure clean separation of concerns and high maintainability.

### Service Layer
- **`UserService`**: Centralized hub for authentication, profile management, and session state.
- **`CartService`**: Reactive state management (`ChangeNotifier`) for real-time basket synchronisation.
- **`NotificationService`**: Orchestrates global application notifications and badge logic.
- **`StorageService`**: High-level API for seamless JSON-to-Storage abstraction.

---

## 📂 Project Structure

```text
lib/
├── main.dart                          # Application Entry Point
├── pages/
│   ├── account/                       # Profile & User Hub
│   │   ├── account_sub_pages/         # Orders, Discounts, Security
│   │   └── components/                # Reusable Profile Components
│   ├── authentication/                # Login & Registration Flows
│   ├── cart/                          # Shopping Basket & Checkout UI
│   │   └── components/                # Summary & Confirmation Sheets
│   ├── categories/                    # Product Discovery by Category
│   ├── home/                          # Primary Storefront
│   ├── layout/                        # Global Navigation Shell
│   └── product/                       # High-Detail Product Pages
├── services/                          # Core Business Logic & State
├── utils/                             # Design System & Data Modules
└── widgets/                           # Global UI Library (Cards, Lists, Inputs)
```

---

## 📦 Installation & Setup

1. **Clone & Navigate**
   ```bash
   git clone https://github.com/yourusername/mini-mart.git
   cd mini-mart
   ```

2. **Initialize Environment**
   ```bash
   flutter pub get
   ```

3. **Execution**
   ```bash
   flutter run
   ```

---

## 🚀 Test Credentials

To explore the full premium experience, use the following pre-configured user credentials:

| Type | Username | Email | Password |
|------|----------|-------|----------|
| **Primary** | apollo | apollo@ | aaaaaaaa |
| **Standard** | Aren | aren@gmail.com | 12121212 |

### Active Promotional Codes
- **`1114`**: 50% Flat Discount (⭐ Highest)
- **`2114`**: 30% Discount
- **`2314`**: 20% Discount

---

## 🤝 Contribution Guidelines

We welcome contributions! Please ensure your code follows the established **Modular Service Pattern** and maintain the 250-line file limit where possible.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License & Legal

Distributed under the **MIT License**. See `LICENSE` for more information.

**Mini Mart Development Team** — Building the future of mobile commerce.
