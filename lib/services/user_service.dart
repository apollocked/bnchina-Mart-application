import 'package:flutter/foundation.dart';
import 'package:minimart/services/storage_service.dart';
import 'package:minimart/services/order_service.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:minimart/services/cart_service.dart';
import 'package:minimart/utils/assets.dart';

class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final StorageService _storage = StorageService();
  final String _userKey = 'current_user';
  final String _registryKey = 'user_profile_registry';

  Map<String, dynamic> _currentUser = {
    "username": "Guest",
    "email": "guest@minimart.com",
    "password": "aaaaaaaa",
    "discount": 0,
    "profileImagePath": avatarBoy,
    "isCustomImage": false,
  };

  // Stores profile path and custom flag keyed by email
  Map<String, dynamic> _userRegistry = {};

  Map<String, dynamic> get currentUser => _currentUser;

  void init() {
    _userRegistry = _storage.getMap(_registryKey) ?? {};

    final Map<String, dynamic>? saved = _storage.getMap(_userKey);
    if (saved != null) {
      _currentUser = saved;
      // Sync from registry if exists (case where current_user was saved but registry updated)
      _syncFromRegistry();
    } else {
      _currentUser = {
        "username": "apollo",
        "email": "apollo@",
        "password": "aaaaaaaa",
        "discount": 0,
        "profileImagePath": "",
        "isCustomImage": false,
      };
      _save();
    }

    // Initialize dependent services for the current user
    if (_currentUser["email"] != null &&
        _currentUser["email"] != "guest@minimart.com") {
      OrderService().refresh(_currentUser["email"]);
      NotificationService().refresh(_currentUser["email"]);
      CartService().refresh(_currentUser["email"]);
    }
  }

  void _syncFromRegistry() {
    final email = _currentUser["email"];
    if (email != null && _userRegistry.containsKey(email)) {
      final profile = _userRegistry[email];
      _currentUser["profileImagePath"] = profile["path"] ?? "";
      _currentUser["isCustomImage"] = profile["isCustom"] ?? false;
      _currentUser["discount"] = profile["discount"] ?? 0;
    }
  }

  void _save() {
    _storage.saveMap(_userKey, _currentUser);
    _storage.saveMap(_registryKey, _userRegistry);
    notifyListeners();
  }

  void login(String email, String password, String username) {
    _currentUser["email"] = email;
    _currentUser["username"] = username;
    _currentUser["password"] = password;

    // Load per-user profile and discount if exists
    if (_userRegistry.containsKey(email)) {
      final profile = _userRegistry[email];
      _currentUser["profileImagePath"] = profile["path"] ?? "";
      _currentUser["isCustomImage"] = profile["isCustom"] ?? false;
      _currentUser["discount"] = profile["discount"] ?? 0;
    } else {
      _currentUser["profileImagePath"] = "";
      _currentUser["isCustomImage"] = false;
      _currentUser["discount"] = 0;
    }

    _save();
    OrderService().refresh(email);
    NotificationService().refresh(email);
    CartService().refresh(email);
    _storage.setLoggedIn(true);
  }

  void logout() {
    clearDiscount();
    _storage.setLoggedIn(false);
    OrderService().clearLocal();
    NotificationService().clearLocal();
    CartService().clearLocal();
    notifyListeners();
  }

  void updateProfile(String username, String email) {
    _currentUser["username"] = username;
    _currentUser["email"] = email;
    _save();
  }

  void updatePassword(String newPassword) {
    _currentUser["password"] = newPassword;
    _save();
  }

  void updateProfileImage({required String path, required bool isCustom}) {
    _currentUser["profileImagePath"] = path;
    _currentUser["isCustomImage"] = isCustom;

    // Update registry
    final email = _currentUser["email"];
    if (email != null) {
      final profile = _userRegistry[email] ?? {};
      profile["path"] = path;
      profile["isCustom"] = isCustom;
      _userRegistry[email] = profile;
    }

    _save();
  }

  void deleteAccount() {
    final email = _currentUser["email"];
    if (email != null) {
      _userRegistry.remove(email);
    }

    _currentUser = {
      "username": "Guest",
      "email": "guest@minimart.com",
      "password": "none",
      "discount": 0,
      "profileImagePath": "",
      "isCustomImage": false,
    };
    _storage.clearAll();
    _storage.setLoggedIn(false);
    notifyListeners();
  }

  void applyDiscount(int discountPercentage) {
    _currentUser["discount"] = discountPercentage;

    // Update registry
    final email = _currentUser["email"];
    if (email != null) {
      final profile = _userRegistry[email] ?? {};
      profile["discount"] = discountPercentage;
      _userRegistry[email] = profile;
    }

    _save();
  }

  void clearDiscount() {
    _currentUser["discount"] = 0;
    _save();
  }
}
