import 'dart:math';
import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String paymentMethod;
  final double amount;
  final String location;
  final String dateRange;
  final int adults;
  final int children;

  PaymentSuccessScreen({
    required this.paymentMethod,
    required this.amount,
    required this.location,
    required this.dateRange,
    required this.adults,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final String refNumber = _generateRefNumber();
    final String date = _getCurrentDate();
    final String time = _getCurrentTime();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset('assets/success.png'),
              ),
              SizedBox(height: 30),
              Text(
                'Payment success!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      InfoRow(label: 'Booking number', value: refNumber),
                      InfoRow(label: 'Date', value: date),
                      InfoRow(label: 'Time', value: time),
                      InfoRow(label: 'Payment method', value: paymentMethod),
                      InfoRow(
                        label: 'Amount',
                        value: '\$${(amount + 10).toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/view_booking',
                    arguments: {
                      'location': location,
                      'dateRange': dateRange,
                      'adults': adults,
                      'children': children,
                    },
                  );
                },
                child: Text('View booking'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateRefNumber() {
    final Random random = Random();
    final int part1 = random.nextInt(900000000) + 100000000; // 9 digits
    final int part2 = random.nextInt(900000000) + 100000000; // 9 digits
    return '$part1$part2';
  }

  String _getCurrentDate() {
    final DateTime now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  }

  String _getCurrentTime() {
    final DateTime now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
