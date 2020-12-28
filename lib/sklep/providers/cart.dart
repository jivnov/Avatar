import 'package:flutter/foundation.dart';
//import 'package:Avatar/Mission.dart';
//import 'package:Avatar/Creation.dart';

import 'package:Avatar/main.dart';
import 'package:Avatar/item.dart';



class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String path;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.path,

  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
    String path,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              path: existingCartItem.path,
              quantity:  1,
            ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1,
              path: path,
            ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
   // var total;
   // _items.forEach((key, cartItem) {
   //   total += cartItem.price * cartItem.quantity;
   // });
   // klient.points = klient.points-total;

    _items.forEach((key, cartItem) {
      Item item = new Item(cartItem.title, cartItem.price, cartItem.path);
      klient.products.add(item);
    });
    _items = {};
    notifyListeners();
  }
}
