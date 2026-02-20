# 🛒 Mini Mart - Flutter E-Commerce App

A feature-rich mobile e-commerce application built with Flutter, allowing users to browse products, manage shopping carts, and place orders with discount codes.

## 📋 Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Usage Guide](#usage-guide)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Key Components](#key-components)
- [Available Coupon Codes](#available-coupon-codes)
- [Test Accounts](#test-accounts)
- [Future Enhancements](#future-enhancements)
- [Contributing](#contributing)
- [License](#license)

---

## ✨ Features

### 🔐 Authentication
- **User Registration** - Create new account with email and password
- **User Login** - Secure login with email and password validation
- **Password Management** - Change password functionality
- **Session Management** - User session persistence during app session
- **Sign Out** - Secure logout with confirmation dialog

### 🏠 Home Page
- **Product Showcase** - Display all available products
- **Category Cards** - Browse top categories with discount badges
- **Trending Products** - Horizontal scrollable list of trending items
- **Category Navigation** - Quick access to all product categories
- **Image Gallery** - Product images with responsive layouts

### 🏪 Product Management
- **Product Details** - Comprehensive product information
- **Category Filtering** - Filter products by category
- **Product Cards** - Display product name, price, and category
- **Trending Indicators** - Mark trending products for quick discovery
- **Price Display** - Show prices in IQD currency

### 🛍️ Shopping Cart
- **Add to Cart** - Add products from home, trending, or product detail pages
- **Quantity Management** - Increase/decrease item quantities
- **Remove Items** - Delete items from cart with quantity adjustment
- **Cart Persistence** - Cart items securely saved via `shared_preferences` across app restarts
- **Dynamic Total Calculation** - Real-time price updates
- **Empty State Handling** - User-friendly empty cart message

### 💳 Checkout & Orders
- **Checkout Process** - One-click checkout from basket page
- **Order History** - View all past orders with details
- **Order ID** - Unique identifiers for tracking orders
- **Order Date** - Timestamp for each purchase
- **Order Items Display** - Horizontal scrollable list of items in each order
- **Order Total** - Final price including applicable discounts

### 🎟️ Discount System
- **Coupon Codes** - Apply discount codes to orders
- **Multiple Coupons** - 5 different coupon codes available
- **Discount Validation** - Verify coupon codes before applying
- **Discount Display** - Show discount percentage in checkout
- **Price Calculation** - Automatic price calculation with discount applied
- **Error Handling** - User-friendly messages for invalid coupons

### 👤 Account Management
- **User Profile** - Display username and email
- **Avatar Display** - User avatar in account section with a premium badge
- **Orders View** - Quick access to order history
- **Password Change** - Secure password update with validation
- **Notifications System** - Live badge count, swipe-to-dismiss notification cards for purchases and coupons
- **Coupon Management** - Apply and view active coupons
- **Logout** - Secure sign-out functionality

### 🎨 UI/UX Features
- **Dark Theme** - Modern dark mode interface
- **Responsive Design** - Optimized for different screen sizes
- **Navigation Bar** - Bottom navigation for easy access (Home, Basket, Account)
- **Custom AppBar** - Location display in app header
- **Toast Notifications** - SnackBar feedback for user actions
- **Loading States** - Visual feedback during operations
- **Icon System** - SVG and PNG icons throughout the app
- **Smooth Animations** - Gesture-based interactions

---

## 📸 Screenshots

### Authentication Screens
- Login page with email/password validation
- Registration page for new users
- Password change confirmation dialog

### Home Screen
- Featured poster/banner
- Category cards with discounts
- Trending products carousel
- Complete product list with prices

### Product Details
- Full product image
- Product name, description, and price
- Category badge
- Add to cart button

### Shopping Basket
- Cart items with images
- Quantity adjustment controls
- Item removal functionality
- Real-time total price calculation
- Checkout button
- Discount applied indicator

### Orders Page
- Order cards with order ID and date
- Product items in each order
- Order total price display
- Horizontal product list per order

### Account Page
- User profile information
- Quick action buttons
- Orders access
- Password change
- Coupon application
- Sign out option

---

## 🏗️ Project Structure

```
mini_mart/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── pages/
│   │   ├── Authotication/
│   │   │   ├── login_page.dart           # User login screen
│   │   │   ├── register_page.dart        # User registration screen
│   │   │   └── change_password_page.dart # Password management
│   │   ├── Account_page/
│   │   │   ├── account_page.dart         # User account dashboard
│   │   │   └── Account_Page_Listtile_pages/
│   │   │       ├── orders_page.dart      # Order history view
│   │   │       ├── discount_page.dart    # Coupon code entry
│   │   │       ├── notifications_page.dart# Notifications hub
│   │   │       ├── signout_massege.dart  # Logout confirmation
│   │   ├── Home_page/
│   │   │   └── home_page.dart            # Main shopping interface
│   │   ├── Basket_Page/
│   │   │   ├── basket_page.dart          # Shopping cart view
│   │   │   └── basket_cart.dart          # Cart item component
│   │   ├── Product_page/
│   │   │   ├── product_item_page.dart    # Product detail view
│   │   │   └── category_page.dart        # Category products list
│   │   └── Layout_page/
│   │       └── layout_page.dart          # Main layout with navigation
│   ├── widgits/
│   │   ├── Custom_Widget/
│   │   │   ├── custom_appbar.dart        # App header component
│   │   │   ├── custom_banner.dart        # Top banner component
│   │   │   ├── custom_snackBar.dart      # Toast notifications
│   │   │   ├── custom_textfeild.dart     # Input field component
│   │   │   └── custom_list_tile.dart     # List item component
│   │   ├── Costum_cards/
│   │   │   ├── orders_card.dart          # Order item card
│   │   │   ├── trending_product_cart.dart# Trending product card
│   │   │   ├── products.dart             # Category products page
│   │   │   └── product_vertical_list.dart# Vertical product list
│   │   ├── categorycard/
│   │   │   ├── categorycarditem.dart     # Category item component
│   │   │   ├── categorycardlist.dart     # Category grid
│   │   │   └── category_text.dart        # Category label
│   │   ├── Item_Lests/
│   │   │   ├── tranding_now_list.dart    # Trending products list
│   │   │   ├── orders_vertical_list.dart # Orders display
│   │   │   └── product_vertical_list.dart# Product list view
│   ├── services/
│   │   ├── storage_service.dart          # Local storage wrapper
│   │   ├── cart_service.dart             # Cart business logic
│   │   ├── user_service.dart             # User profile & coupons
│   │   ├── order_service.dart            # Order history logic
│   │   └── notification_service.dart     # Notifications logic
│   └── utils/
│       ├── colors.dart                   # Color definitions
│       ├── assets.dart                   # Asset paths
│       └── data.dart                     # App data and state
├── assets/
│   ├── images/                           # Product & category images
│   ├── icons/                            # SVG & PNG icons
│   └── categories/                       # Category images
├── pubspec.yaml                          # Dependencies
└── README.md                             # This file
```

---

## 📦 Installation

### Prerequisites
- Flutter SDK (v3.0 or higher)
- Dart SDK (v3.0 or higher)
- Android Studio / Xcode for emulators
- Git for version control

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/mini-mart.git
   cd mini-mart
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

4. **Build APK (Android)**
   ```bash
   flutter build apk --release
   ```

5. **Build iOS**
   ```bash
   flutter build ios --release
   ```

---

## 🚀 Getting Started

### First Time Setup

1. **Launch the app** - You'll land on the login page
2. **Create an account** - Click "Sign up" to register
3. **Login** - Use your credentials to access the app
4. **Browse products** - Explore home page, categories, and trending items
5. **Add to cart** - Click the + button on any product
6. **Checkout** - View your cart and proceed to purchase
7. **Apply coupon** - Use discount codes for savings
8. **View orders** - Check your order history in the account section

### Test Accounts

Use these pre-populated accounts to test the app:

| Username | Email | Password | Notes |
|----------|-------|----------|-------|
| apollo | apollo@ | aaaaaaaa | Default account |
| Aren | aren@gmail.com | 12121212 | Test user |
| Hevar | hevar@gmail.com | 12121212 | Test user |
| Arkan | arkan@gmail.com | 12121212 | Test user |

---

## 📖 Usage Guide

### 🛒 Shopping Workflow

#### 1. Browse Products
- **Home Page**: Scroll to see all products and trending items
- **Categories**: Tap "See all categories" to filter by type
- **Search**: Use category cards to navigate specific product types

#### 2. Add Products to Cart
```
Options to add items:
- Click '+' on trending product cards
- Click '+' on product list items
- View product details → Click "Add to basket"
```

#### 3. Manage Cart
- **Increase Quantity**: Tap '+' button next to item
- **Decrease Quantity**: Tap '-' button next to item
- **Remove Item**: Decrease quantity to 0 (auto-removes)

#### 4. Apply Discount Code
```
Steps:
1. Go to Account page (bottom right icon)
2. Tap "Coupons"
3. Enter coupon code
4. Click "Check Coupon Code"
5. Discount applies to next purchase
```

#### 5. Complete Checkout
```
Steps:
1. Go to Basket page
2. Review items and total price
3. Click "Check out"
4. Order is created with unique Order ID
5. Cart clears and discount resets
```

#### 6. View Orders
```
Steps:
1. Go to Account page
2. Tap "Orders"
3. View all past orders with items and totals
4. See order ID and purchase date
```

### 👤 Account Management

#### Change Password
```
Steps:
1. Go to Account page
2. Tap "Change password"
3. Enter old password
4. Enter new password (2x)
5. Confirm change
```

#### View Profile
- Username and email displayed on Account page
- Avatar shown as profile picture

#### Sign Out
```
Steps:
1. Go to Account page
2. Tap "Sign out"
3. Confirm in dialog
4. Redirected to login page
```

---

## 🎟️ Available Coupon Codes

```
Code: 2314  | Discount: 20%
Code: 2114  | Discount: 30%
Code: 1114  | Discount: 50%  ⭐ Highest
Code: 2333  | Discount: 5%
Code: 2364  | Discount: 25%
```

### How to Use Coupons
1. Navigate to Account → Coupons
2. Enter a coupon code from the list above
3. If valid, discount percentage will be applied
4. The discount applies to the next order total
5. Invalid codes show an error message

---

## 🏛️ Architecture

### State Management & Persistence Pattern
The application uses a **Services Architecture** coupled with `shared_preferences` to ensure localized data persistence.
- **`StorageService`** - Singleton wrapper for serializing JSON data to device storage.
- **`UserService`** - Manages user profile and applied coupons across app restarts.
- **`CartService`** (ChangeNotifier) - Manages the cart state, updates quantities, handles discounted checkout totals, and rebuilds the UI effectively when items change.
- **`OrderService`** - Archives purchases into persistent order history.
- **`NotificationService`** - Holds live badge notification arrays and serializes/parses `DateTime` stamps correctly into JSON.

### Data Flow
```
User Input
   ↓
Page/Widget
   ↓
Service Method (e.g. CartService().addToCart(product))
   ↓
Service State Update + notifyListeners()
   ↓
StorageService (Saves state locally to device)
   ↓
UI Rebuild via ListenableBuilder
   ↓
Display Updated Data
```

### Key Service Methods

#### `CartService().addToCart(product)`
- Adds product to `basketItems` or increases its quantity
- Automatically persists the encoded JSON into `SharedPreferences`
- Triggers UI rebuilds across layout elements listening to the Cart.

#### `UserService().applyDiscount(percentage)`
- Validates and applies a coupon code reduction percentage.
- Saves the coupon session securely.
- Automatically pushes a success/failure message to `NotificationService`.

#### `CartService().getDiscountedTotal()`
- Calculates total from all basket items dynamically.
- Automatically subtracts active User Session percentage reductions.

#### `NotificationService().addNotification()`
- Central notification builder for Purchase and Coupon Alerts.
- Safely manages unread badge counts globally.

---

## 🎨 Color Scheme (New Premium Dark Theme)

| Color | Hex Code | Usage |
|-------|----------|-------|
| Deep Navy | #0D1B2A | Main background |
| Charcoal | #1A2B3C | Card surfaces, bottom nav, dialogs |
| Vibrant Emerald | #00C897 | Primary buttons, active icons, highlights |
| Soft Teal | #00E5C4 | Accents, gradients |
| Coral Red | #FF5B5B | Errors, delete actions |
| Muted Blue-Grey | #8FA3B1 | Sub-text, inactive icons |

Located in: `utils/colors.dart`

---

## 📱 Widget Components

### Custom Widgets

#### CustomField
- Input field with icon prefix
- Validation support
- Used for login/register/password forms

#### CustomSnackbar
- Toast notification system
- Customizable colors and messages
- Auto-dismiss after 2 seconds

#### CustomAppBar
- Location display (Erbil)
- Navigation header
- Used across all pages

#### CustomBanner
- Top banner on auth pages
- Logo/branding display
- 300px height

#### CustomTile
- Account page menu items
- Click handlers
- Dark grey background

### Product Cards

#### ProductCard (Trending)
- Horizontal scrollable card
- Product image, name, price
- Quick add button
- 150x140px size

#### OrdersCard
- Shows order items
- Product name, quantity, price
- Compact vertical layout
- 130x auto height

#### VerticalListcard
- Full-width product display
- Image, details, price
- Add to basket button
- 80px height

---

## 🔧 Key Technologies

```yaml
dependencies:
  flutter: sdk: flutter
  flutter_svg: ^2.0.0          # SVG icon support
  intl: ^0.18.0                # Date formatting
  shortid: ^0.1.1              # Generate unique IDs
  font_awesome_flutter: ^10.4.0 # Icon library
```

---

## 🐛 Known Limitations

1. **Authentication**: No backend validation, local only. Passwords stored in plain text (development only).
2. **Global State**: The architecture relies on Singleton Service patterns (`ChangeNotifier`). Larger scale would require Provider/Riverpod.
3. **Payment**: No payment gateway integration
4. **Images**: All images stored locally, no CDN content.
5. **Real-time**: No push notifications
6. **Search**: No search functionality implemented

---

## 📸 File Details

### Pages (10 files)
- **home_page.dart** (173 lines) - Main shopping interface
- **login_page.dart** (180 lines) - User authentication
- **register_page.dart** (185 lines) - New user signup
- **basket_page.dart** (225 lines) - Shopping cart with checkout
- **account_page.dart** (135 lines) - User dashboard
- **product_item_page.dart** (125 lines) - Product details
- **change_password_page.dart** (170 lines) - Password management
- **orders_page.dart** (95 lines) - Order history
- **discount_page.dart** (95 lines) - Coupon entry
- **layout_page.dart** (95 lines) - Main navigation container

### Widgets (13 files)
- **Custom Components**: 5 reusable custom widgets
- **Cards**: 3 card/item components
- **Lists**: 4 list display components

### Services (5 files)
- **cart_service.dart**, **user_service.dart**, **order_service.dart**, **notification_service.dart** - Core business logic handling state and data parsing
- **storage_service.dart** - Secure local JSON string persistence engine

### Utils (3 files)
- **colors.dart** - 12 color definitions
- **assets.dart** - 22 asset path constants
- **data.dart** - Sample data (products, users, coupons)

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow Flutter best practices
- Add comments for complex logic
- Test thoroughly before submitting
- Update README for new features
- Keep code clean and formatted

---

## 📝 Code Style Guide

```dart
// ✅ DO
const String appName = "Mini Mart";
final TextEditingController controller = TextEditingController();
void addToCart(Product product) { }

// ❌ DON'T
String AppName = "Mini Mart";
var controller = TextEditingController();
addToCart(dynamic item) { }
```

---

## 🆘 Troubleshooting

### App Won't Start
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Build Errors
```bash
# Update dependencies
flutter pub upgrade

# Get latest SDK
flutter upgrade
```

### Hot Reload Not Working
- Save file properly
- Check for syntax errors
- Restart the app completely

### Cart Data Lost
- This should no longer occur! Restarting the app retains state via `SharedPreferences`. If data acts corrupt, clear app cache strings.

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Author

**Mini Mart Development Team**
- Flutter App Development
- E-Commerce Platform

---

## 📧 Support

For issues, questions, or suggestions:
1. Check existing issues on GitHub
2. Create a new issue with detailed description
3. Contact development team

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for UI inspiration
- All contributors and testers

---

## 📊 Project Statistics

- **Total Files**: 35
- **Lines of Code**: ~3,800+
- **Pages**: 11
- **Custom Widgets**: 13
- **Services**: 5
- **Products Available**: 15
- **Categories**: 10
- **Test Accounts**: 4
- **Coupon Codes**: 5

---

## 🎯 Next Steps

1. **Test the app** using provided test accounts
2. **Explore all pages** to understand functionality
3. **Try coupon codes** to see discount system
4. **Review code** for learning purposes
5. **Plan enhancements** based on your needs

---

**Last Updated**: February 2026
**App Version**: 1.0.0
**Flutter Version**: 3.0+
**Platform**: iOS & Android

---

For more information, please refer to the [Flutter Documentation](https://flutter.dev/docs) or visit the [project repository](https://github.com/yourusername/mini-mart).
