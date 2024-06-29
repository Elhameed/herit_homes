import 'package:flutter/material.dart';

class FiltersTypeOfPlaceScreen extends StatefulWidget {
  @override
  _FiltersTypeOfPlaceScreenState createState() => _FiltersTypeOfPlaceScreenState();
}

class _FiltersTypeOfPlaceScreenState extends State<FiltersTypeOfPlaceScreen> {
  RangeValues _priceRange = RangeValues(10, 250);
  bool _entirePlace = true;
  bool _privateRoom = false;
  bool _dormitories = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Filters', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                Expanded(
                  child: RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 500,
                    divisions: 50,
                    labels: RangeLabels(
                      '\$${_priceRange.start.round()}',
                      '\$${_priceRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Minimum\nUS\$${_priceRange.start.round()}'),
                Text('Maximum\nUS\$${_priceRange.end.round()}'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Type of place',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Entire place\nEntire apartments, condos, houses'),
              value: _entirePlace,
              onChanged: (bool? value) {
                setState(() {
                  _entirePlace = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Private room\nTypically come with a private bathroom unless otherwise stated'),
              value: _privateRoom,
              onChanged: (bool? value) {
                setState(() {
                  _privateRoom = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Dormitories\nLarge rooms with multiple beds that are shared with others'),
              value: _dormitories,
              onChanged: (bool? value) {
                setState(() {
                  _dormitories = value ?? false;
                });
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/filter_facilities');
                  },
                  child: Text('View Results'),
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
