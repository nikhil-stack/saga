import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga/providers/cart.dart';
import 'package:saga/screens/cart_screen.dart';
import 'package:saga/screens/items_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Cart(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ItemsScreen(),
          routes: {
            '/cart_screen': (ctx) => CartScreen(),
          }),
    );
  }
}
