import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../feature/firebase_auth_services.dart'; // Import Firebase Auth

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      showErrorDialog(
          'Invalid credentials. Please enter a valid email and/or password');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void resetPassword(String email) async {
    if (email.isEmpty) {
      showErrorDialog('Email field cannot be empty.');
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop(); // Close the dialog after sending the email
      showErrorDialog('Password reset link sent! Check your email.');
    } catch (e) {
      showErrorDialog('Credentials not found.');
    }
  }

  void showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController resetEmailController = TextEditingController();
        return AlertDialog(
          title: Text('Reset Password'),
          content: TextField(
            controller: resetEmailController,
            decoration: InputDecoration(
              labelText: 'Enter your email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => resetPassword(resetEmailController.text.trim()),
              child: Text('Send Link'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email addess',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            TextButton(
              onPressed: () => showResetPasswordDialog(),
              child: Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/getting_started');
              },
              child: Text('Sign up'),
            ),
            Divider(height: 30),
            Text('or continue with'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: ImageIcon(AssetImage('assets/google_icon.png')),
                    iconSize: 35.0,
                    onPressed: () async {
                      final _AuthService = FirebaseAuthService();
                      var user = await _AuthService.signInWithGoogle();
                      if (user != null) {
                        Navigator.pushNamed(context, '/home');
                      }
                    }),
                IconButton(
                    icon: Icon(Icons.apple),
                    onPressed: () async {
                      final _AuthService = FirebaseAuthService();
                      var user = await _AuthService.signInWithApple();
                      if (user != null) {
                        Navigator.pushNamed(context, '/home');
                      }
                    }),
                IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () async {
                      final _AuthService = FirebaseAuthService();
                      var user = await _AuthService.signInWithFacebook();
                      if (user != null) {
                        Navigator.pushNamed(context, '/home');
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
