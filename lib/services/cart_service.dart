import 'package:flutter/foundation.dart';
import 'package:minimart/services/storage_service.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final StorageService _storage = StorageService();
  final String _cartKey = 'basket_items';

  List<Map<String, dynamic>> _basketItems = [];

  // Expose as an unmodifiable list
  List<Map<String, dynamic>> get basketItems => _basketItems;

  void init() {
    _basketItems = _storage.getList(_cartKey);
  }

  void _save() {
    _storage.saveList(_cartKey, _basketItems);
    notifyListeners();
  }

  void addToCart(Map<String, dynamic> product) {
    bool found = false;
    for (var element in _basketItems) {
      if (product["name"] == element["name"]) {
        // Exists: Increase quantity
        int count = element["quantity"] ?? 1;
        element["quantity"] = count + 1;

        num basePrice = element["price"] ?? 0;
        element["totalPrice"] = (count + 1) * basePrice;

        found = true;
        break;
      }
    }

    if (!found) {
      // New item
      Map<String, dynamic> newItem = Map<String, dynamic>.from(product);
      newItem["quantity"] = 1;
      newItem["totalPrice"] = newItem["price"];
      _basketItems.add(newItem);
    }
    _save();
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _basketItems.length) {
      var item = _basketItems[index];
      int count = item["quantity"] ?? 0;
      num basePrice = item["price"] ?? 0;

      item["quantity"] = count + 1;
      item["totalPrice"] = (count + 1) * basePrice;
      _save();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < _basketItems.length) {
      var item = _basketItems[index];
      int count = item["quantity"] ?? 1;
      num basePrice = item["price"] ?? 0;

      if (count > 1) {
        item["quantity"] = count - 1;
        item["totalPrice"] = (count - 1) * basePrice;
      } else {
        _basketItems.removeAt(index);
      }
      _save();
    }
  }

  void clearCart() {
    _basketItems.clear();
    _save();
  }

  double getTotal() {
    double total = 0.0;
    for (var element in _basketItems) {
      total += (element["totalPrice"] as num? ?? 0).toDouble();
    }
    return total;
  }

  // Passing the current discount from UserService
  double getDiscountedTotal(int discountPercentage) {
    if (discountPercentage == 0) return getTotal();

    double total = getTotal();
    double discountAmount = total * (discountPercentage / 100);
    return total - discountAmount;
  }
}
