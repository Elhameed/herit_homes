import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herit_homes/screens/payment_screen.dart';

class ConfirmAndPayScreen extends StatefulWidget {
  @override
  _ConfirmAndPayScreenState createState() => _ConfirmAndPayScreenState();
}

class _ConfirmAndPayScreenState extends State<ConfirmAndPayScreen> {
  int _selectedPaymentOption = 1; // 1 for 'Pay in full', 2 for 'Pay a part now'
  int _selectedPaymentMethod = 1; // 1 for 'Card', 2 for 'Cash'
  TextEditingController _partPaymentController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardExpiryController = TextEditingController();
  TextEditingController _cardCVVController = TextEditingController();
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
  void dispose() {
    _partPaymentController.dispose();
    _cardNumberController.dispose();
    _cardExpiryController.dispose();
    _cardCVVController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm and Pay'),
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
                          Text('May 1 - 6', style: TextStyle(fontSize: 18)),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Guests', style: TextStyle(fontSize: 18)),
                          Text('1 guest', style: TextStyle(fontSize: 18)),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 30, color: Colors.grey),
              Text('Payment options',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('Pay in full', style: TextStyle(fontSize: 18)),
                subtitle: Text('Pay full amount now to finalize your booking.'),
                leading: Radio(
                  value: 1,
                  groupValue: _selectedPaymentOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedPaymentOption = value!;
                      _partPaymentController.clear();
                      _updateTotalAmount();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Pay a part now', style: TextStyle(fontSize: 18)),
                subtitle: Text(
                    'You can make a partial payment now and the remaining amount at a later time.'),
                leading: Radio(
                  value: 2,
                  groupValue: _selectedPaymentOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedPaymentOption = value!;
                      _updateTotalAmount();
                    });
                  },
                ),
              ),
              if (_selectedPaymentOption == 2)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _partPaymentController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter amount',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _updateTotalAmount();
                    },
                  ),
                ),
              Divider(height: 30, color: Colors.grey),
              Text('Payment method',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('Card', style: TextStyle(fontSize: 18)),
                leading: Radio(
                  value: 1,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
              if (_selectedPaymentMethod == 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _cardExpiryController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                CardExpiryInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Expiry Date (MM/YY)',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _cardCVVController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ListTile(
                title: Text('Cash', style: TextStyle(fontSize: 18)),
                leading: Radio(
                  value: 2,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
              Divider(height: 30, color: Colors.grey),
              Text('Price details',
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
                child: Text('Book now'),
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
