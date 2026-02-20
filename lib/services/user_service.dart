import 'package:minimart/services/storage_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final StorageService _storage = StorageService();
  final String _userKey = 'current_user';

  Map<String, dynamic> _currentUser = {
    "username": "Guest",
    "email": "guest@minimart.com",
    "password": "none",
    "discount": 0,
  };

  Map<String, dynamic> get currentUser => _currentUser;

  void init() {
    final Map<String, dynamic>? saved = _storage.getMap(_userKey);
    if (saved != null) {
      _currentUser = saved;
    } else {
      // Create default
      _currentUser = {
        "username": "apollo",
        "email": "apollo@",
        "password": "aaaaaaaa",
        "discount": 0,
      };
      _save();
    }
  }

  void _save() {
    _storage.saveMap(_userKey, _currentUser);
  }

  void login(String email, String password) {
    // Dummy login
    _currentUser["email"] = email;
    _currentUser["username"] = email.split("@").first;
    _currentUser["password"] = password;
    _save();
  }

  void logout() {
    clearDiscount();
  }

  void updatePassword(String newPassword) {
    _currentUser["password"] = newPassword;
    _save();
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
