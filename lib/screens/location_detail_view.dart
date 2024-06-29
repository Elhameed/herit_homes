import 'package:flutter/material.dart';

class LocationDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lagos City Tours'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Lagos City Tours',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'By Motley Travels',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.green, size: 16),
                Icon(Icons.star, color: Colors.green, size: 16),
                Icon(Icons.star, color: Colors.green, size: 16),
                Icon(Icons.star, color: Colors.green, size: 16),
                Icon(Icons.star_half, color: Colors.green, size: 16),
                SizedBox(width: 5),
                Text('6 reviews', style: TextStyle(color: Colors.blue)),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage('assets/nigeria_image1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Explore the vast historic collections at the National museum, walk through a range of Art works at the Nike Art Gallery and...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'from',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '\$100.00',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'per adult (price varies by group size)',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/select_time_range');
              },
              child: Text('Book on Viator'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lowest price guarantee • Reserve now & pay later • Free cancellation',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
