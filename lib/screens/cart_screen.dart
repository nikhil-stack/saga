
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga/providers/cart.dart';
import 'package:saga/widgets/cart_item.dart' as cartitem;

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Cart>(context).getItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: cart.getItems == null
          ? Center(
              child: Text('No items added yet!'),
            )
          : Column(
              children: [
                Card(
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Chip(
                          label: Text(
                            'Rs ' + cart.totalAmount.toStringAsFixed(2),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .title
                                    .color),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        TextButton(onPressed: null, child: Text('Order Now'))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return cartitem.CartItem(
                        id: cart.items.values.toList()[i].id,
                        price: cart.items.values.toList()[i].price,
                        quantity: cart.items.values.toList()[i].quantity,
                        title: cart.items.values.toList()[i].title,
                        url: cart.items.values.toList()[i].url,
                      );
                    },
                    itemCount: cart.items.length,
                  ),
                ),
              ],
            ),
    );
  }
}
