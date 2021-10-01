import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:saga/widgets/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String url;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.url,
  });

  CartItem.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        title = json['title'],
        price = json['price'],
        id = json['id'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'url': url,
        'title': title,
        'price': price,
        'id': id,
        'quantity': quantity,
      };
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
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total + 0.0;
  }

  Future<void> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> itemMap;
    for (int i = 1; i <= 4; i++) {
      final itemString = prefs.getString(i.toString());
      if (itemString != null) {
        itemMap = jsonDecode(itemString) as Map<String, dynamic>;
      }
      if (itemMap != null) {
        final CartItem ci = CartItem.fromJson(itemMap);
        if (_items.containsKey(ci.id)) {
          _items.update(
            ci.id,
            (value) => CartItem(
              id: ci.id,
              title: ci.title,
              quantity: ci.quantity,
              price: ci.price,
              url: ci.url,
            ),
          );
        } else {
          _items.putIfAbsent(
            ci.id,
            () => CartItem(
              id: ci.id,
              quantity: 1,
              price: ci.price,
              title: ci.title,
              url: ci.url,
            ),
          );
        }
      }
    }
    notifyListeners();
  }

  void addItem(String id, String title, double price, String url) async {
    if (_items.containsKey(id)) {
      /* _items.update(
        id,
        (value) {
          return CartItem(
            quantity: value.quantity + 1,
            price: value.price,
            title: value.title,
            id: value.id,
            url: value.url,
          );
        },
      );*/
      final pref = await SharedPreferences.getInstance();
      final data = jsonDecode(pref.getString(id)) as Map<String, dynamic>;
      final CartItem cartItem = CartItem.fromJson({
        'url': url,
        'title': title,
        'price': price,
        'id': id,
        'quantity': data['quantity'] + 1,
      });
      await pref.setString(id, jsonEncode(cartItem));
      print(pref.getString(id));
    } else {
      /*_items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          quantity: 1,
          price: price,
          title: title,
          url: url,
        ),
      );*/
      final pref = await SharedPreferences.getInstance();
      final CartItem cartItem = CartItem.fromJson({
        'url': url,
        'title': title,
        'price': price,
        'id': id,
        'quantity': 1,
      });
      await pref.setString(id, jsonEncode(cartItem));
      print(pref.getString(id));
    }
    notifyListeners();
  }
}
