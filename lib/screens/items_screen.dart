import 'package:flutter/material.dart';
import 'package:saga/models/products.dart';

class ItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saga'),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => Navigator.of(context).pushNamed('/cart_screen'),),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2),
        itemBuilder: (ctx, i) => products[i],
        itemCount: products.length,
      ),
    );
  }
}
