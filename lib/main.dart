import 'package:flutter/material.dart';
import 'package:frutivity/screens/favorites.dart';
import 'package:frutivity/screens/registration_screen.dart';
import 'package:frutivity/screens/welcome_screen.dart';
import 'screens/main_screen.dart';
import 'screens/product_details.dart';
import 'screens/cart.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';

List<dynamic> carrito = [];
List<dynamic> favoritos = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        ProductDetails.id: (context) => ProductDetails(),
        Cart.id: (context) => Cart(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        FavoritePage.id: (context) => FavoritePage(),
      },
    );
  }
}
