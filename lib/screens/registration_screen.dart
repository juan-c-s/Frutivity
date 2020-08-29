import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_screen.dart';
import 'package:frutivity/complements/login_button.dart';
import 'package:frutivity/complements/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'product_details.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:frutivity/db/users.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance; //created instance to call
  final _formKey = GlobalKey<FormState>();
  final databaseRf = FirebaseDatabase.instance.reference();
  UserServices _userServices = UserServices();
  String email;
  String name;
  String password;
  bool hide = true;
  bool spinner = false;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
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
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
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
                height: 28.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameTextController,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Nombre Completo',
                          prefixIcon: Icon(Icons.person_outline)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      obscureText: hide,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kInputDecoration.copyWith(
                        hintText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              hide = false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: hide,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        password = value;
                        if (value.isEmpty) {
                          return "La contraseña no puede estar vacía";
                        } else if (value.length < 6) {
                          return "la contraseña debe ser por lo menos 6 characteres de largo";
                        } else if (_passwordTextController != value) {
                          return "La contraseña no coincide";
                        }
                        return null;
                      },
                      decoration: kInputDecoration.copyWith(
                        hintText: 'Confimar Contraseña',
                        hintStyle: TextStyle(),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              hide = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: InkWell(
                      child: Text(
                        'Ya tienes cuenta?',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quesha',
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                  ),
                ],
              ),
              LogInButton(
                color: Color(0xFFFBDE58),
                onPressed: () async {
                  validateForm();
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
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
                text: 'Registrar',
                textColor: Colors.black54,
              ),
              Divider(
                color: Colors.white,
                thickness: 0.8,
                indent: 60,
                endIndent: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
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

  Future validateForm() async {
    FirebaseUser user = await _auth.currentUser();

    databaseRf.child("users").push().set({
      "username": name,
      "email": email,
      "userId": user.uid,
    });
  }
}
