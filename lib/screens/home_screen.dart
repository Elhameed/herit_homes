import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herit_homes/feature/profile_service.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  User? user;
  String? userFirstName;
  String? userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user!.providerData.any((info) => info.providerId == 'google.com')) {
        // For Google sign-in users
        userFirstName = user!.displayName?.split(' ')[0];
        userPhotoUrl = user!.photoURL;
      } else {
        // For other sign-in methods
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        userFirstName = userDoc.data()?['firstName'];
        userPhotoUrl = userDoc.data()?['photoUrl'];
      }
    } else {
      userFirstName = 'Client';
    }
    setState(() {});
  }

  void _handleBottomNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/search');
        break;
      case 1:
        Navigator.pushNamed(context, '/house_details');
        break;
      case 2:
        Navigator.pushNamed(context, '/Confirm_and_Pay');
        break;
      case 3:
        Navigator.pushNamed(context, '/inbox');
        break;
      case 4:
        _showProfileMenu(context);
        break;
    }
  }

  void _handleLogout() {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/getting_started', (route) => false);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign out: $e'),
        ),
      );
    });
  }

  Future<void> _handleDeleteAccount() async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .delete();
          await user!.delete();
          Navigator.pushNamedAndRemoveUntil(
              context, '/getting_started', (route) => false);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete account: $e'),
          ),
        );
      }
    }
  }

  void _showProfileMenu(BuildContext context) {
    _getUserDetails().then((_) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, 500, 100, 0),
        items: [
          PopupMenuItem(
            child: ListTile(
              title: Text('Dear $userFirstName!',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: GestureDetector(
                onTap: () async {
                  final profileService = ProfileService();
                  await profileService.changeProfilePicture();
                  // Ensure the user details are updated
                  await _getUserDetails();
                  Navigator.of(context).pop(); // Close the menu
                },
                child: CircleAvatar(
                  backgroundImage: userPhotoUrl != null
                      ? NetworkImage(userPhotoUrl!)
                      : AssetImage('assets/default_user.png') as ImageProvider,
                ),
              ),
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
              onTap: _handleLogout,
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title:
                  Text('Delete account', style: TextStyle(color: Colors.red)),
              onTap: _handleDeleteAccount,
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome!',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
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
          unselectedItemColor: Colors.purple,
          currentIndex: _currentIndex,
          onTap: _handleBottomNavigationTap,
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
        SizedBox(height: 10),
        AccommodationCard(
          imageUrl: 'assets/kenya-apartment.png',
          title: 'Apartment in Kenya',
          location: 'Beach',
          price: '\$30/night',
          rating: '5.0',
        ),
        SizedBox(height: 10),
        AccommodationCard(
          imageUrl: 'assets/uganda-apartment.png',
          title: 'Apartment in Uganda',
          location: 'Beach',
          price: '\$40/night',
          rating: '5.0',
        ),
        SizedBox(height: 10),
        AccommodationCard(
          imageUrl: 'assets/rwanda-apartment.png',
          title: 'Apartment in Rwanda',
          location: 'Beach',
          price: '\$20/night',
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/facilities');
      },
      child: Card(
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
      ),
    );
  }
}
