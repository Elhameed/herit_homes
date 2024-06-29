import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Image.network(
            'https://yourimageurl.com/image.png',
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            'Looking for the perfect place to relax and unwind? This stunning Balinese villa is the ultimate tropical getaway. Located on a quiet street just minutes from the beach, this beautiful home offers everything you need for a luxurious and comfortable stay.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Icon(Icons.location_pin, color: Colors.purple),
              SizedBox(width: 4),
              Text(
                'FCT-Abuja, Nigeria',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  // Implement the map opening functionality here
                },
                child: Text('Open map'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Consectetur magna consectetur',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Voluptate magna fugiat tempor incididunt',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Aliqua in in mollit laboris tempor in ut incididunt',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DescriptionScreen(),
  ));
}
