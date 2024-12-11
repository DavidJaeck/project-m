import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class AuthWidget extends StatefulWidget {
  final Function(String, String) loginCallback;

  const AuthWidget({required this.loginCallback});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  bool _isLogin = true; // Track if the user is in "Login" or "Register" mode

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin; // Toggle between login and register
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: Column(
        children: [
          // Toggle buttons for switching between login and register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() => _isLogin = true);
                },
                child: Text('Login', style: TextStyle(color: _isLogin ? Colors.blue : Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  setState(() => _isLogin = false);
                },
                child: Text('Register', style: TextStyle(color: !_isLogin ? Colors.blue : Colors.grey)),
              ),
            ],
          ),
          Expanded(
            child: _isLogin
                ? LoginScreen(loginCallback: widget.loginCallback)
                : RegisterScreen(loginCallback: widget.loginCallback),
          ),
        ],
      ),
    );
  }
}
