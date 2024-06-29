import 'package:flutter/material.dart';

class FacilitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facilities & Services'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Facilities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildFacilityItem(Icons.people, '2 Guests'),
          _buildFacilityItem(Icons.bed, '1 bedroom'),
          _buildFacilityItem(Icons.single_bed, '1 bed'),
          _buildFacilityItem(Icons.bathtub, '1 bath'),
          _buildFacilityItem(Icons.wifi, 'Wifi'),
          _buildFacilityItem(Icons.kitchen, 'Kitchen'),
          _buildFacilityItem(Icons.fitness_center, 'Exercise equipment'),
          _buildFacilityItem(Icons.pool, 'Pool'),
          _buildFacilityItem(Icons.park, 'Garden'),
          SizedBox(height: 20),
          Text(
            'Services',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Cleaning & laundry',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          _buildServiceItem(Icons.local_laundry_service, 'Washer'),
          _buildServiceItem(Icons.local_laundry_service, 'Free dryer - In unit'),
          _buildServiceItem(Icons.iron, 'Iron'),
          SizedBox(height: 10),
          Text(
            'Bathroom',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          _buildServiceItem(Icons.bathtub, 'Bathtub'),
          _buildServiceItem(Icons.airline_seat_individual_suite, 'Hair dryer'),
        ],
      ),
    );
  }

  Widget _buildFacilityItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }

  Widget _buildServiceItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FacilitiesScreen(),
  ));
}
