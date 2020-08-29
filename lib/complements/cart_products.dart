import 'package:flutter/material.dart';
import 'package:frutivity/complements/constants.dart';
import 'package:frutivity/main.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsOnCart = [
    {
      "name": "Aguacate",
      "picture": 'images/Aguacate.jpg',
      "price": 500,
      "quantity": 1,
      "details":
          'El aguacate Hass o palta Hass son los nombres comunes del fruto de Persea americana pertenecientes a la variedad "Hass", originada a partir de una semilla de raza guatemalteca en un huerto de Rudolph Hass en la Habra, California en 1926, patentada en 1935 e introducida globalmente en el mercado en 1960; es la variedad más cultivada a nivel mundial.',
    },
    {
      "name": "Banano",
      "picture": 'images/Banano.jpg',
      "price": 300,
      "quantity": 1,
      "details": 'Bananos frescas cultivados en el suroeste Antioqueño.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carrito.length,
      itemBuilder: (context, index) {
        return SingleCartProduct(
          cartProductName: carrito[index]["name"],
          cartProductPicture: carrito[index]["picture"],
          cartProductPrice: carrito[index]["price"],
          cartProductQuantity: carrito[index]["quantity"],
        );
      },
    );
  }
}

class SingleCartProduct extends StatefulWidget {
  SingleCartProduct(
      {this.cartProductName,
      this.cartProductPicture,
      this.cartProductPrice,
      this.cartProductQuantity});
  final cartProductName;
  final cartProductPrice;
  final cartProductPicture;
  int cartProductQuantity;

  @override
  _SingleCartProductState createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          width: 327,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              //LEADING SECTION
              leading: Image.asset(
                widget.cartProductPicture,
                width: 100,
                height: 100,
              ),
              title: Text(widget.cartProductName.toString()),
              subtitle: Column(
                children: <Widget>[
                  //ROW INSIDE COLUMN
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '\$${widget.cartProductPrice}',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_drop_up,
              ),
              onPressed: () {
                setState(() {
                  widget.cartProductQuantity++;
                });
              },
            ),
            Text('${widget.cartProductQuantity.toString()}'),
            IconButton(
              icon: Icon(
                Icons.arrow_drop_down,
              ),
              onPressed: () {
                setState(() {
                  widget.cartProductQuantity--;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
