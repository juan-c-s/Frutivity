import 'package:flutter/material.dart';
import 'package:frutivity/complements/constants.dart';
import 'package:frutivity/complements/products.dart';
import 'package:frutivity/screens/cart.dart';
import 'package:frutivity/screens/main_screen.dart';
import 'package:frutivity/main.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails(
      {this.productDetailName,
      this.productDetailPicture,
      this.productDetailPrice,
      this.productDetailInfo,
      this.productQuantity});
  final productDetailName;
  final productDetailPicture;
  final productDetailPrice;
  final productDetailInfo;
  final productQuantity;
  static const id = 'ProductDetails';
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool heartActivated = false;
  bool isRepeated;
  void oneElement() {
    for (var element in carrito) {
      if (element['name'] == element['name']) {
        carrito.remove(element['name']);
      }
      print(element);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oneElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EDE1),
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.teal,
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, MainScreen.id);
          },
          child: Text(
            'Frutivity',
            style: kTitleTextStyle,
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, Cart.id);
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.productDetailPicture),
              ),
              footer: Container(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.productDetailName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          '\$' '${widget.productDetailPrice} por kilo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //===firstButton===
          Row(children: <Widget>[
            Expanded(
                child: MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Cantidad'),
                        content: Text('Escoja Cantidad'),
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cerrar'),
                          ),
                        ],
                      );
                    });
              },
              color: Colors.white,
              textColor: Colors.grey,
              elevation: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Cantidad'),
                  ),
                  Expanded(
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ))
          ]),

          //====secondButton====
          Row(children: <Widget>[
            Expanded(
                child: MaterialButton(
              padding: EdgeInsets.all(12),
              onPressed: () {},
              color: Colors.teal,
              textColor: Colors.white,
              elevation: 2.0,
              child: Text('Compra ya'),
            )),
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              color: Colors.teal,
              onPressed: () {
                for (var element in carrito) {
                  print(element["name"]);
                  if (element['name'] == widget.productDetailName) {
                    isRepeated = true;
                  }
                }
                if (isRepeated != true) {
                  carrito.add({
                    "name": widget.productDetailName,
                    "price": widget.productDetailPrice,
                    "picture": widget.productDetailPicture,
                    "quantity": widget.productQuantity,
                  });
                }
              },
            ),
            IconButton(
              icon: heartActivated == true
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              color: Colors.teal,
              onPressed: () {
                setState(() {
                  heartActivated = !heartActivated;
                });
                if (isRepeated != true && heartActivated == true) {
                  favoritos.add({
                    "name": widget.productDetailName,
                    "price": widget.productDetailPrice,
                    "picture": widget.productDetailPicture,
                    "quantity": widget.productQuantity,
                  });
                }
              },
            ),
          ]),
          Divider(),
          ListTile(
            title: Padding(
                child: Text('Sobre el Producto'),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3)),
            subtitle: Text(
              '${widget.productDetailInfo}',
            ),
          ),
          Divider(),

          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 50, 5),
                child: Text('Producto'),
              ),
              Text(widget.productDetailName),
            ],
          ),
          ListTile(
            title: Text('Información'),
            subtitle: Text(
                'Todos los productos que vende esta marca vienen directamente de los agricultores'),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Similar Products'),
          ),
          Container(
            height: 360,
            child: SimilarProducts(),
          )
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return SimilarSingleProduct(
            productName: productList[index]['name'],
            productPicture: productList[index]['picture'],
            productPrice: productList[index]['price'],
            productDetails: productList[index]['details'],
            productQuantity: productList[index]['quantity']);
      },
    );
  }
}

class SimilarSingleProduct extends StatelessWidget {
  SimilarSingleProduct(
      {this.productName,
      this.productPicture,
      this.productPrice,
      @required this.productDetails,
      this.productQuantity});
  final productName;
  final productPicture;
  final productPrice;
  final productDetails;
  final productQuantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: productName,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        productDetailPrice: productPrice,
                        productDetailPicture: productPicture,
                        productDetailName: productName,
                        productDetailInfo: productDetails,
                        productQuantity: productQuantity,
                      ))),
              child: GridTile(
                footer: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  color: Colors.white70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          productName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '$productPrice',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                child: Image.asset(
                  productPicture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}
