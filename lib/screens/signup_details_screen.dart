import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herit_homes/feature/firebase_auth_services.dart';
import 'package:intl/intl.dart';
import 'package:herit_homes/screens/login_screen.dart'; // Import your login screen

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  bool _agreedToTOS = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _pickDateDialog() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue ?? false;
    });
  }

  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    final firebaseAuthService = FirebaseAuthService();
    User? user = await firebaseAuthService.signUpWithEmailAndPassword(
        email, password, firstName, lastName);

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      print("User registered successfully!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()), // Navigate to login screen
      );
    } else {
      print("Failed to register user.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register user.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Few more steps')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First name on ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last name on ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _pickDateDialog,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _birthdayController,
                    decoration: InputDecoration(
                      labelText: 'Birthday (dd/mm/yyyy)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your birthday';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
                          .hasMatch(value)) {
                    return 'Password must be at least 8 characters and include a number, symbol, and capital letter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                value: _agreedToTOS,
                onChanged: _setAgreedToTOS,
                title:
                    Text('I agree to the Terms of Service and Privacy Policy.'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.black,
              ),
              ElevatedButton(
                onPressed: _agreedToTOS
                    ? _isLoading
                        ? null
                        : registerUser
                    : null,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : const Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _agreedToTOS ? Colors.black : Colors.grey,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
