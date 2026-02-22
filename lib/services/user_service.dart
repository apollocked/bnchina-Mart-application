import 'package:flutter/foundation.dart';
import 'package:minimart/services/storage_service.dart';

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
    "password": "none",
    "discount": 0,
    "profileImagePath": "",
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
  }

  void _syncFromRegistry() {
    final email = _currentUser["email"];
    if (email != null && _userRegistry.containsKey(email)) {
      final profile = _userRegistry[email];
      _currentUser["profileImagePath"] = profile["path"] ?? "";
      _currentUser["isCustomImage"] = profile["isCustom"] ?? false;
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

    // Load per-user profile if exists
    if (_userRegistry.containsKey(email)) {
      final profile = _userRegistry[email];
      _currentUser["profileImagePath"] = profile["path"] ?? "";
      _currentUser["isCustomImage"] = profile["isCustom"] ?? false;
    } else {
      _currentUser["profileImagePath"] = "";
      _currentUser["isCustomImage"] = false;
    }

    _save();
    _storage.setLoggedIn(true);
  }

  void logout() {
    clearDiscount();
    _storage.setLoggedIn(false);
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
      _userRegistry[email] = {
        "path": path,
        "isCustom": isCustom,
      };
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
    _save();
  }

  void clearDiscount() {
    _currentUser["discount"] = 0;
    _save();
  }
}
