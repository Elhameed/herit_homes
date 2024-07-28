// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:herit_homes/screens/add_guests_screen.dart';
import 'package:herit_homes/screens/select_time_range_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
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
                        DropdownMenuItem(child: Text('Kenya'), value: 'Kenya'),
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: [
                  buildCountryTile('Nigeria', 'assets/nigeria.png'),
                  buildCountryTile('Rwanda', 'assets/rwanda.png'),
                  buildCountryTile('Kenya', 'assets/kenya.png'),
                ],
              ),
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
                      builder: (context) =>
                          SelectTimeRangeScreen(location: selectedCountry!),
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
                          location: selectedCountry!),
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
            Spacer(),
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/search');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/house_details');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/Confirm_and_Pay');
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

  Widget buildCountryTile(String countryName, String imagePath) {
    bool isSelected = selectedCountry == countryName;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCountry = countryName;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: Colors.blue.shade700, width: 4)
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(countryName),
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
