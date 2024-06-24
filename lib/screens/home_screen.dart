import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.beach_access), text: "Beach"),
              Tab(icon: Icon(Icons.terrain), text: "Mountain"),
              Tab(icon: Icon(Icons.local_florist), text: "Camping"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AccommodationList(),
            Center(child: Text('Mountain')),
            Center(child: Text('Camping')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class AccommodationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        AccommodationCard(
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCTxGVtzFCKs7Oo7AUdqaBEJUjGdCHgZA0LXFtuxobLY2JY46A',
          title: 'Apartment in Nigeria',
          location: 'Beach',
          price: '\$40/night',
          rating: '5.0',
        ),
        SizedBox(height: 10),
        AccommodationCard(
          imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnaze1lMZ32ryMv5EMDEBHCXaX0A5RYpw-x2lBLEQTV2SPtrhI',
          title: 'Apartment in Rwanda',
          location: 'Beach',
          price: '\$32/night',
          rating: '5.0',
        ),
      ],
    );
  }
}

class AccommodationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final String rating;

  AccommodationCard({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 16),
                        Text(rating),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
