import 'package:flutter/material.dart';

class AddGuestsScreen extends StatefulWidget {
  final String dateRange;
  final String location;

  AddGuestsScreen({Key? key, required this.dateRange, required this.location})
      : super(key: key);

  @override
  _AddGuestsScreenState createState() => _AddGuestsScreenState();
}

class _AddGuestsScreenState extends State<AddGuestsScreen> {
  int adults = 1;
  int children = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text("Add Guests"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '${widget.location}',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '${widget.dateRange}',
                labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
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
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the next step or confirm the booking details
                    Navigator.pushNamed(context, '/filter_type_of_place',
                        arguments: {
                          'location': widget.location,
                          'dateRange': widget.dateRange,
                          'adults': adults,
                          'children': children
                        });
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(100, 50),
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
