import 'package:firebase_database/firebase_database.dart';

class UserServices {
  final _database = FirebaseDatabase.instance;
  String ref = "users";
  createUser(Map value) {
    String id = value["userId"];

    _database.reference().child("users").set(value).catchError((e) => print(
          e.toString(),
        ));
  }
}
