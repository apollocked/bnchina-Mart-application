import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- Dynamic List Storage (for Carts, Orders, Notifications) ---

  Future<void> saveList(String key, List<Map<String, dynamic>> value) async {
    final String jsonString = jsonEncode(value);
    await _prefs.setString(key, jsonString);
  }

  List<Map<String, dynamic>> getList(String key) {
    final String? jsonString = _prefs.getString(key);
    if (jsonString == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      return [];
    }
  }

  // --- Map Storage (for User Profile) ---

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    final String jsonString = jsonEncode(value);
    await _prefs.setString(key, jsonString);
  }

  Map<String, dynamic>? getMap(String key) {
    final String? jsonString = _prefs.getString(key);
    if (jsonString == null) return null;

    try {
      final Map<String, dynamic> decoded = jsonDecode(jsonString);
      return decoded;
    } catch (e) {
      return null;
    }
  }

  // --- Simple types ---

  bool get isLoggedIn => _prefs.getBool('isLoggedIn') ?? false;

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool('isLoggedIn', value);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}








