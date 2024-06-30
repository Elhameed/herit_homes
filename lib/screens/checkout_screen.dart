import 'package:flutter/material.dart';

class ConfirmAndPayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm and Pay'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home_details.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              Text('\$20/night', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('Balian treehouse', style: TextStyle(fontSize: 18)),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text('5.0 (262)', style: TextStyle(fontSize: 18)),
                ],
              ),
              Divider(height: 30, color: Colors.grey),
              Text('Your trip', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dates', style: TextStyle(fontSize: 18)),
                          Text('May 1 - 6', style: TextStyle(fontSize: 18)),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Guests', style: TextStyle(fontSize: 18)),
                          Text('1 guest', style: TextStyle(fontSize: 18)),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 30, color: Colors.grey),
              Text('Payment options', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('Pay in full', style: TextStyle(fontSize: 18)),
                subtitle: Text('Pay \$30 now to finalize your booking.'),
                leading: Radio(
                  value: 1,
                  groupValue: 0,
                  onChanged: (int? value) {},
                ),
              ),
              ListTile(
                title: Text('Pay a part now', style: TextStyle(fontSize: 18)),
                subtitle: Text('You can make a partial payment now and the remaining amount at a later time.'),
                leading: Radio(
                  value: 1,
                  groupValue: 0,
                  onChanged: (int? value) {},
                ),
              ),
              Divider(height: 30, color: Colors.grey),
              Text('Price details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$20 x 1 night', style: TextStyle(fontSize: 18)),
                  Text('\$20', style: TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kayak fee', style: TextStyle(fontSize: 18)),
                  Text('\$5', style: TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Street parking fee', style: TextStyle(fontSize: 18)),
                  Text('\$5', style: TextStyle(fontSize: 18)),
                ],
              ),
              Divider(height: 30, color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total (USD)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('\$30', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment_success');
                },
                child: Text('Book now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
