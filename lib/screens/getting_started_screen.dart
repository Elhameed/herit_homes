import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../feature/firebase_auth_services.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  List<Map<String, dynamic>> _countries = [];
  String? _selectedCountryCode;
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    loadCountryData().then((data) {
      setState(() {
        _countries = data;
      });
    });
    _phoneController.addListener(checkFormValidity);
  }

  @override
  void dispose() {
    _phoneController.removeListener(checkFormValidity);
    _phoneController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> loadCountryData() async {
    final jsonString = await rootBundle.loadString('assets/country_code.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((jsonItem) => jsonItem as Map<String, dynamic>)
        .toList();
  }

  void checkFormValidity() {
    if (_selectedCountryCode != null &&
        _phoneController.text.isNotEmpty &&
        isValidPhoneNumber(_phoneController.text)) {
      if (!_isButtonDisabled) return;
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      if (_isButtonDisabled) return;
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^\(\+\d{1,3}\)\s?\d{3,}$');
    return regex.hasMatch(phoneNumber);
  }

  void navigateToNextPage() {
    if (!_isButtonDisabled) {
      Navigator.pushNamed(context, '/signup_details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Started')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Get Started',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: _selectedCountryCode,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Country Code',
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountryCode = newValue;
                  _phoneController.text = "($newValue) ";
                  checkFormValidity();
                });
              },
              items: _countries.map<DropdownMenuItem<String>>(
                  (Map<String, dynamic> country) {
                return DropdownMenuItem<String>(
                  value: country['dial_code'],
                  child: Text("${country['name']} (${country['dial_code']})"),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonDisabled ? null : navigateToNextPage,
              child: Text('Sign up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
                disabledBackgroundColor: Colors.grey.withOpacity(0.12),
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
                IconButton(
                    icon: ImageIcon(AssetImage('assets/google_icon.png')),
                    onPressed: () {}),
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
