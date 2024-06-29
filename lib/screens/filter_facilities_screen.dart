import 'package:flutter/material.dart';

class FiltersFacilitiesScreen extends StatefulWidget {
  @override
  _FiltersFacilitiesScreenState createState() => _FiltersFacilitiesScreenState();
}

class _FiltersFacilitiesScreenState extends State<FiltersFacilitiesScreen> {
  int _bedrooms = 0;
  int _beds = 0;
  int _bathrooms = 0;
  bool _kitchen = true;
  bool _pool = false;
  bool _gym = false;
  bool _outdoorSpace = true;
  bool _internetAccess = true;

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
              'Rooms and beds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bedrooms', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_bedrooms > 0) _bedrooms--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.grey),
                    ),
                    Text(_bedrooms == 0 ? 'Any' : _bedrooms.toString(), style: TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _bedrooms++;
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
                Text('Beds', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_beds > 0) _beds--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.grey),
                    ),
                    Text(_beds == 0 ? 'Any' : _beds.toString(), style: TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _beds++;
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
                Text('Bathrooms', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_bathrooms > 0) _bathrooms--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.grey),
                    ),
                    Text(_bathrooms == 0 ? 'Any' : _bathrooms.toString(), style: TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _bathrooms++;
                        });
                      },
                      icon: Icon(Icons.add, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Facilities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Kitchen'),
              value: _kitchen,
              onChanged: (bool? value) {
                setState(() {
                  _kitchen = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Pool'),
              value: _pool,
              onChanged: (bool? value) {
                setState(() {
                  _pool = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Gym'),
              value: _gym,
              onChanged: (bool? value) {
                setState(() {
                  _gym = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Outdoor space'),
              value: _outdoorSpace,
              onChanged: (bool? value) {
                setState(() {
                  _outdoorSpace = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Internet access'),
              value: _internetAccess,
              onChanged: (bool? value) {
                setState(() {
                  _internetAccess = value ?? false;
                });
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _bedrooms = 0;
                      _beds = 0;
                      _bathrooms = 0;
                      _kitchen = false;
                      _pool = false;
                      _gym = false;
                      _outdoorSpace = false;
                      _internetAccess = false;
                    });
                  },
                  child: Text('Clear all'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/house_details');
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
