import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herit_homes/feature/bottom_navigation_bar.dart';
import 'package:herit_homes/feature/profile_service.dart';
import 'package:herit_homes/screens/add_guests_screen.dart';
import 'package:herit_homes/screens/select_time_range_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedCountry;
  User? user;
  String? userFirstName;
  String? userPhotoUrl;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user!.providerData.any((info) => info.providerId == 'google.com')) {
        userFirstName = user!.displayName?.split(' ')[0];
        userPhotoUrl = user!.photoURL;
      } else {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        userFirstName = userDoc['firstName'];
        userPhotoUrl = userDoc['photoUrl'];
      }
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

  void _handleDeleteAccount() async {
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

  void _showProfileMenu(BuildContext context) {
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
                setState(() {
                  _getUserDetails(); // Refresh user details after updating the profile picture
                });
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
            title: Text('Delete account', style: TextStyle(color: Colors.red)),
            onTap: _handleDeleteAccount,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                'Where to?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: selectedCountry,
                        items: [
                          DropdownMenuItem(
                              child: Text('Nigeria'), value: 'Nigeria'),
                          DropdownMenuItem(
                              child: Text('Rwanda'), value: 'Rwanda'),
                          DropdownMenuItem(
                              child: Text('Kenya'), value: 'Kenya'),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildCountryTile('Nigeria', 'assets/nigeria.png'),
                  buildCountryTile('Rwanda', 'assets/rwanda.png'),
                  buildCountryTile('Kenya', 'assets/kenya.png'),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'When',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  if (selectedCountry != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectTimeRangeScreen(
                          location: selectedCountry!,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a location first.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Guests',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                ),
                readOnly: true,
                onTap: () {
                  if (selectedCountry != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddGuestsScreen(
                          dateRange: "2024-01-01 to 2024-01-07",
                          location: selectedCountry!,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a location first.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedCountry = null;
                      });
                    },
                    child: Text('Clear all'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (selectedCountry != null) {
                        Navigator.pushNamed(context, '/location_detail_view');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select a country.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.search),
                    label: Text('Get Details'),
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
      bottomNavigationBar: BottomNavigationBarWidget(
        onTap: _handleBottomNavigationTap,
        currentIndex: _currentIndex,
      ),
    );
  }

  Widget buildCountryTile(String countryName, String imagePath) {
    bool isSelected = selectedCountry == countryName;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCountry = countryName;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            countryName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
