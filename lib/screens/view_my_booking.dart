// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ViewMyBookingScreen extends StatefulWidget {
  final String location;
  final String dateRange;
  final int adults;
  final int children;

  ViewMyBookingScreen(
      {super.key,
      required this.location,
      required this.dateRange,
      required this.adults,
      required this.children});

  @override
  _ViewMyBookingScreenState createState() => _ViewMyBookingScreenState();
}

class _ViewMyBookingScreenState extends State<ViewMyBookingScreen> {
  int _selectedPaymentOption = 1; // 1 for 'Pay in full', 2 for 'Pay a part now'
  int _selectedPaymentMethod = 1; // 1 for 'Card', 2 for 'Cash'
  TextEditingController _partPaymentController = TextEditingController();
  double _totalAmount = 200.0;
  double _partPayment = 0.0;

  void _updateTotalAmount() {
    if (_selectedPaymentOption == 2) {
      _partPayment = double.tryParse(_partPaymentController.text) ?? 0.0;
      setState(() {
        _totalAmount = _partPayment * 5;
      });
    } else {
      setState(() {
        _totalAmount = 200.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _partPaymentController.addListener(_updateTotalAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booking'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home_details.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              Text('\$40/night',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('Balian treehouse', style: TextStyle(fontSize: 18)),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text('5.0 (262)', style: TextStyle(fontSize: 18)),
                ],
              ),
              Divider(height: 30, color: Colors.grey),
              Text('Your trip',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dates', style: TextStyle(fontSize: 18)),
                          Text('2024-07-30 to 2024-08-02',
                              style: TextStyle(fontSize: 18)),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/select_time_range');
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Guests', style: TextStyle(fontSize: 18)),
                          Text('2 guest', style: TextStyle(fontSize: 18)),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(context, '/add_guests');
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 30, color: Colors.grey),
              Text('Payment details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_selectedPaymentOption == 1)
                    Text('\$40 x 5 nights', style: TextStyle(fontSize: 18)),
                  if (_selectedPaymentOption == 2)
                    Text(
                      '\$${_partPayment.toStringAsFixed(2)} x 5 nights',
                      style: TextStyle(fontSize: 18),
                    ),
                  if (_selectedPaymentOption == 1)
                    Text('\$200', style: TextStyle(fontSize: 18)),
                  if (_selectedPaymentOption == 2)
                    Text(
                      '\$${(_partPayment * 5).toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kayak fee', style: TextStyle(fontSize: 18)),
                  Text('\$5', style: TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Street parking fee', style: TextStyle(fontSize: 18)),
                  Text('\$5', style: TextStyle(fontSize: 18)),
                ],
              ),
              Divider(height: 30, color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total (USD)',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('\$${(_totalAmount + 10).toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/payment_success',
                    arguments: {
                      'paymentMethod':
                          _selectedPaymentMethod == 1 ? 'Card' : 'Cash',
                      'amount': _totalAmount, // Ensure _totalAmount is not null
                    },
                  );
                },
                child: Text('view receipt'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/search');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/favorites');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/confirm_and_pay');
          }
          if (index == 3) {
            Navigator.pushNamed(context, '/inbox');
          }
          if (index == 4) {
            _showProfileMenu(context);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(AntDesign.search1),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.heart),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialIcons.book),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.message),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialIcons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 500, 100, 0),
      items: [
        PopupMenuItem(
          child: ListTile(
            title: Text('Dear User!',
                style: TextStyle(fontWeight: FontWeight.bold)),
            leading: Icon(Icons.account_circle),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text('Continue'),
            onTap: () {
              Navigator.of(context).pop(); // Close the menu
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/getting_started', (route) => false);
            },
          ),
        ),
      ],
    );
  }
}

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 2) {
      text = text.substring(0, 2) + '/' + text.substring(2, text.length);
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
