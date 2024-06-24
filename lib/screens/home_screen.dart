import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accommodation Listing')),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Container(
            height: 200,
            child: Card(
              child: Column(
                children: <Widget>[
                  Image.network('https://via.placeholder.com/150', fit: BoxFit.cover), // Replace with actual image URLs
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Apartment in Nigeria'),
                      subtitle: Text('Beach - \$40/night'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: Card(
              child: Column(
                children: <Widget>[
                  Image.network('https://via.placeholder.com/150', fit: BoxFit.cover), // Replace with actual image URLs
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Apartment in Rwanda'),
                      subtitle: Text('Beach - \$32/night'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
