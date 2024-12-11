import 'package:flutter/material.dart';
import 'default_screen.dart';
import 'auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppWidget(), // Set the root widget to AppWidget
    );
  }
}

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  bool _isLoggedIn = false; // Manages login state

  void _loginUser(String email, String password) {
    // Simulate a login process (e.g., call an API or Firebase)
    print('User logged in with Email: $email and Password: $password');
    setState(() {
      _isLoggedIn = true; // User is now logged in
    });
  }

  void _logoutUser() {
    setState(() {
      _isLoggedIn = false; // User is now logged out
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn
        ? DefaultScreen(logoutCallback: _logoutUser)
        : AuthWidget(loginCallback: _loginUser);
  }
}