import 'package:flutter/material.dart';
import 'screens/launch_screen.dart';
import 'screens/getting_started_screen.dart';
import 'screens/signup_details_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/location_details_screen.dart';
import 'screens/location_detail_view.dart';
import 'screens/select_time_range_screen.dart';
import 'screens/add_guests_screen.dart';
import 'screens/filter_type_of_place_screen.dart';
import 'screens/filter_facilities_screen.dart';
import 'screens/house_details_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/facilities_screen.dart';
import 'screens/description_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Herithomes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LaunchScreen(),
        '/getting_started': (context) => GettingStartedScreen(),
        '/signup_details': (context) => SignupDetailsScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/location_details': (context) => LocationDetailsScreen(),
        '/location_detail_view': (context) => LocationDetailView(),
        '/select_time_range': (context) => SelectTimeRangeScreen(),
        '/add_guests': (context) => AddGuestsScreen(),
        '/filter_type_of_place': (context) => FiltersTypeOfPlaceScreen(),
        '/filter_facilities': (context) => FiltersFacilitiesScreen(),
        '/house_details': (context) => HouseDetailsScreen(),
        '/Confirm_and_Pay': (context) => ConfirmAndPayScreen(),
        '/reviews': (context) => ReviewsScreen(),
        '/payment_success': (context) => PaymentSuccessScreen(),
        '/facilities': (context) => FacilitiesScreen(),
        '/description': (context) => DescriptionScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
