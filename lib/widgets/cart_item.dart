import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String url;
  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
    @required this.url,
  });
  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: Rs ' + (price * quantity).toStringAsFixed(2)),
          trailing: Text(quantity.toString() + 'x' + price.toString()),
        ),
      ),
    );
  }
}
