import 'package:frutivity/main.dart';
import 'package:flutter/material.dart';
import 'package:frutivity/screens/main_screen.dart';

class FavoritePage extends StatefulWidget {
  static const String id = 'favoritePage';
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, MainScreen.id);
          },
          child: Text(
            'Frutivity',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (BuildContext context, int index) {}),
        ],
      ),
    );
  }
}
