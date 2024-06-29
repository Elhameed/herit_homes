import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
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
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      items: [
                        DropdownMenuItem(child: Text('Nigeria'), value: 'Nigeria'),
                        DropdownMenuItem(child: Text('Rwanda'), value: 'Rwanda'),
                        DropdownMenuItem(child: Text('Kenya'), value: 'Kenya'),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/location_details');
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/nigeria.png', width: 100, height: 100), // Ensure you have the image in the assets
                      Text('Nigeria'),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Image.asset('assets/rwanda.png', width: 100, height: 100), // Ensure you have the image in the assets
                    Text('Rwanda'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/kenya.png', width: 100, height: 100), // Ensure you have the image in the assets
                    Text('Kenya'),
                  ],
                ),
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
                Navigator.pushNamed(context, '/select_time_range');
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
                Navigator.pushNamed(context, '/add_guests');
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Clear all'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  label: Text('Search'),
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
    );
  }
}
