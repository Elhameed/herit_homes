import 'package:flutter/material.dart';

class AddGuestsScreen extends StatefulWidget {
  @override
  _AddGuestsScreenState createState() => _AddGuestsScreenState();
}

class _AddGuestsScreenState extends State<AddGuestsScreen> {
  int adults = 0;
  int children = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Location',
                ),
                controller: TextEditingController(text: 'Nigeria'),
                readOnly: true,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Dates',
                ),
                controller: TextEditingController(text: '23 - 31 May'),
                readOnly: true,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'How many guests?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Adults', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (adults > 0) adults--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.grey),
                    ),
                    Text(adults.toString(), style: TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          adults++;
                        });
                      },
                      icon: Icon(Icons.add, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 1, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Children', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (children > 0) children--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.grey),
                    ),
                    Text(children.toString(), style: TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          children++;
                        });
                      },
                      icon: Icon(Icons.add, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      adults = 0;
                      children = 0;
                    });
                  },
                  child: Text('Clear all'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/filter_type_of_place');
                  },
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
