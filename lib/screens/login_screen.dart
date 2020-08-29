import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frutivity/complements/login_button.dart';
import 'package:frutivity/complements/constants.dart';
import 'package:frutivity/screens/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;
  SharedPreferences preferences;

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await account.authentication;

      if (account == null) {
        return false;
      }
      AuthResult res = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken,
        ),
      );
      if (res.user == null) {
        return false;
      } else if (res.user != null) {
        final QuerySnapshot result = await Firestore.instance
            .collection("users")
            .where("id", isEqualTo: res.user.uid)
            .getDocuments();
        final List<DocumentSnapshot> documents = result.documents;

        if (documents.length == 0) {
          Firestore.instance
              .collection("users")
              .document(res.user.uid)
              .setData({
            "id": res.user.uid,
            "username": res.user.displayName,
            "profilePicture": res.user.photoUrl,
          });
          await preferences.setString("id", res.user.uid);
          await preferences.setString("id", res.user.uid);
          await preferences.setString("id", res.user.uid);
        } else {
          await preferences.setString("id", documents[0]["id"]);
          await preferences.setString("username", documents[0]["username"]);
          await preferences.setString("photoUrl", documents[0]["photoUrl"]);
        }
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    await _auth.currentUser().then((user) {
      if (user != null) {
        setState(() {
          isLoggedIn = true;
        });
        if (isLoggedIn == true) {
          Navigator.pushNamed(context, MainScreen.id);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/logo2.png'),
                  )
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kInputDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    kInputDecoration.copyWith(hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              LogInButton(
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });

                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, MainScreen.id);
                    }
                    setState(() {
                      spinner = false;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      spinner = false;
                    });
                  }
                },
                text: 'Login',
                textColor: Colors.black54,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: Text(
                  'No tienes cuenta? Regístrate ya',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quesha',
                    fontSize: 12,
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 0.8,
                indent: 60,
                endIndent: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'or',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quesha',
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 0.8,
                indent: 60,
                endIndent: 60,
              ),
              MaterialButton(
                padding: EdgeInsets.all(15),
                child: CircleAvatar(
                  child: Image.asset('images/google.png'),
                ),
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  bool res = await loginWithGoogle();
                  if (!res) {
                    print('error logging with google');
                  } else {
                    Navigator.pushNamed(context, MainScreen.id);
                  }

                  setState(() {
                    spinner = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
