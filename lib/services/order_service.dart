import 'package:minimart/services/storage_service.dart';
import 'package:intl/intl.dart';
import 'package:shortid/shortid.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final StorageService _storage = StorageService();
  String _ordersKey = 'order_history';

  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  void init() {
    // Basic init if needed, though refresh() usually handles it
    _orders = _storage.getList(_ordersKey);
  }

  void refresh(String email) {
    _ordersKey = 'order_history_$email';
    _orders = _storage.getList(_ordersKey);
  }

  void clearLocal() {
    _ordersKey = 'order_history';
    _orders = [];
  }

  void _save() {
    _storage.saveList(_ordersKey, _orders);
  }

  void placeOrder({
    required List<Map<String, dynamic>> basketItems,
    required double finalTotal,
  }) {
    // Save a deep copy of basket items
    final List<Map<String, dynamic>> basketCopy =
        List<Map<String, dynamic>>.from(
            basketItems.map((e) => Map<String, dynamic>.from(e)));

    _orders.insert(0, {
      "OrderID": shortid.generate(),
      "date": DateFormat.yMMMMd().add_jm().format(DateTime.now()),
      "TotalPrice": finalTotal.toStringAsFixed(2),
      "Data": basketCopy,
    });

    _save();
  }

  void clearHistory() {
    _orders.clear();
    _save();
  }
}
