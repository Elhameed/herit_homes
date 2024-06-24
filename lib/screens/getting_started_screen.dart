import 'package:flutter/material.dart';

class GettingStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Started')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Get Started',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Country/Region',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup_details');
              },
              child: Text('Sign up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Have an account? Login'),
            ),
            Divider(height: 30),
            Text('or continue with'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(icon: Icon(Icons.g_translate), onPressed: () {}),
                IconButton(icon: Icon(Icons.apple), onPressed: () {}),
                IconButton(icon: Icon(Icons.facebook), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
