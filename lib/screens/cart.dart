import 'package:flutter/material.dart';
import 'package:frutivity/complements/constants.dart';

// My imports
import 'package:frutivity/complements/cart_products.dart';

class Cart extends StatefulWidget {
  static const id = 'Cart';
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.teal,
        title: Text(
          'Carrito',
          style: kTitleTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: CartProducts(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total: '),
                subtitle: Text('\$230'),
              ),
            ),
            Expanded(
                child: MaterialButton(
              onPressed: () {},
              child: Text('Check out'),
              color: Colors.teal,
              textColor: Colors.white,
            ))
          ],
        ),
      ),
    );
  }
}
