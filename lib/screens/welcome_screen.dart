import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:frutivity/complements/login_button.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/logo2.png'),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            LogInButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'Log In',
              color: Color(0xFFF1EDE1),
              textColor: Colors.black54,
            ),
            LogInButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              color: Color(0xFFFBDE58),
              text: 'Register',
              textColor: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
