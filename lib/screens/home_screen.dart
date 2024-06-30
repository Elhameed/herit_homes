import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 214, 164, 224),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Feather.sun), text: "Beach"),
              Tab(icon: Icon(MaterialIcons.terrain), text: "Mountain"),
              Tab(icon: Icon(MaterialCommunityIcons.tent), text: "Camping"),
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
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/search');
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
          imageUrl: 'assets/nigeria-apartment.png',
          title: 'Apartment in Nigeria',
          location: 'Beach',
          price: '\$40/night',
          rating: '5.0',
        ),
        SizedBox(height: 10),
        AccommodationCard(
          imageUrl: 'assets/rwanda-apartment.png',
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
          Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity),
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
