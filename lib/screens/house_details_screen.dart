import 'package:flutter/material.dart';

class HouseDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House Details'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/home_details.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Balian Treehouse',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Kigali, Rwanda',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text('4.5/5'),
                      Text(' • 262 reviews',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child:
                        Text('View map', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              Divider(),
              Text(
                'Facilities & services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2 Guests', style: TextStyle(fontSize: 16)),
                        Text('1 bedroom', style: TextStyle(fontSize: 16)),
                        Text('1 bed', style: TextStyle(fontSize: 16)),
                        Text('1 bath', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.wifi),
                            SizedBox(width: 8),
                            Text('Wifi', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.kitchen),
                            SizedBox(width: 8),
                            Text('Kitchen', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.pool),
                            SizedBox(width: 8),
                            Text('Pool', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.grass),
                            SizedBox(width: 8),
                            Text('Garden', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/facilities');
                },
                child: Text('Show all', style: TextStyle(color: Colors.blue)),
              ),
              Divider(),
              Text(
                'Reviews',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text('4.5/5', style: TextStyle(fontSize: 16)),
                ],
              ),
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/edwards.png')),
                title: Text('Jimmy Osin'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                          5,
                          (index) =>
                              Icon(Icons.star, color: Colors.yellow, size: 16)),
                    ),
                    Text(
                        'The location was perfect. The house was spacious and clean, and the amenities...'),
                  ],
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/christy.png')),
                title: Text('Chris Doe'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                          5,
                          (index) =>
                              Icon(Icons.star, color: Colors.yellow, size: 16)),
                    ),
                    Text(
                        'We loved staying here! The place had all the necessary facilities...'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reviews');
                },
                child: Text('See all', style: TextStyle(color: Colors.blue)),
              ),
              Divider(),
              Text(
                'Policies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'House rules',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16),
                        SizedBox(width: 8),
                        Text('Earliest check-in time: 14:00',
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16),
                        SizedBox(width: 8),
                        Text('Latest check-out time: 12:00',
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Checkin policies',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'It\'s always a good idea to confirm the check-in policy directly with the owner/manager before your arrival so that you can...',
                style: TextStyle(fontSize: 14),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('View more', style: TextStyle(color: Colors.blue)),
                    Icon(Icons.chevron_right, color: Colors.blue),
                  ],
                ),
              ),
              Divider(),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/description.png'), // Replace with actual image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                  'Looking for the perfect place to relax and unwind? This stunning Balinese villa is the ultimate tropical getaway. Located on a quiet street just minutes from the beach, this...'),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/description');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('View more', style: TextStyle(color: Colors.blue)),
                    Icon(Icons.chevron_right, color: Colors.blue),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'From: \$20/night',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Confirm_and_Pay');
                    },
                    child: Text('Book now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(150, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
