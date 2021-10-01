import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga/providers/cart.dart';

class Product extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String id;
  Product({
    this.imageUrl,
    this.title,
    this.price,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Item successfully added!',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
              cart.addItem(
                id,
                title,
                price,
                imageUrl,
              );
            },
          ),
        ),
      ),
    );
  }
}
