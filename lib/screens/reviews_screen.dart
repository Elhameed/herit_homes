import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '262 reviews',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      '4.5/5',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < 4 ? Icons.star : Icons.star_half,
                          color: Colors.amber,
                          size: 30,
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(5, (index) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text('${5 - index}'),
                          ),
                          Expanded(
                            flex: 5,
                            child: LinearProgressIndicator(
                              value: (5 - index) / 5.0,
                              backgroundColor: Colors.grey.shade300,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
            Divider(height: 30),
            Expanded(
              child: ListView(
                children: [
                  ReviewItem(
                    name: 'John King',
                    time: 'A day ago',
                    rating: 5,
                    review:
                    'We loved staying in this charming home! It had all the amenities we needed, and the historic...',
                  ),
                  ReviewItem(
                    name: 'Jennifer Harris',
                    time: 'A day ago',
                    rating: 3,
                    review:
                    'While the location of this home was convenient, we were disappointed with the cleanliness and overall...',
                  ),
                  ReviewItem(
                    name: 'John Edwards',
                    time: 'One month ago',
                    rating: 5,
                    review:
                    'This home was perfect for our family vacation! The kids loved the pool and the game room...',
                  ),
                  ReviewItem(
                    name: 'Elizabeth Lopez',
                    time: 'A day ago',
                    rating: 5,
                    review:
                    'The photos don\'t do this home justice - it\'s absolutely stunning in person...',
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

class ReviewItem extends StatelessWidget {
  final String name;
  final String time;
  final int rating;
  final String review;

  const ReviewItem({
    required this.name,
    required this.time,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Text(name[0]),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(time),
                ],
              ),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(review),
        Divider(height: 30),
      ],
    );
  }
}
