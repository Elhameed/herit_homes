import 'package:flutter/material.dart';
import 'screens/view_my_booking.dart';
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => LaunchScreen());
          case '/getting_started':
            return MaterialPageRoute(
                builder: (context) => GettingStartedScreen());
          case '/signup_details':
            return MaterialPageRoute(builder: (context) => SignupScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/home':
            return MaterialPageRoute(builder: (context) => HomeScreen());
          case '/search':
            return MaterialPageRoute(builder: (context) => SearchScreen());
          case '/select_time_range':
            return MaterialPageRoute(
                builder: (context) => SelectTimeRangeScreen(location: ''));
          case '/add_guests':
            return MaterialPageRoute(
                builder: (context) =>
                    AddGuestsScreen(dateRange: '', location: ''));
          case '/filter_type_of_place':
            return MaterialPageRoute(
                builder: (context) => FiltersTypeOfPlaceScreen());
          case '/filter_facilities':
            return MaterialPageRoute(
                builder: (context) => FiltersFacilitiesScreen());
          case '/house_details':
            return MaterialPageRoute(
                builder: (context) => HouseDetailsScreen());
          case '/confirm_and_pay':
            if (settings.arguments != null) {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => ConfirmAndPayScreen(
                  dateRange: args['dateRange'],
                  adults: args['adults'],
                  location: args['location'],
                  children: args['children'],
                ),
              );
            }
            return MaterialPageRoute(
                builder: (context) => ConfirmAndPayScreen(
                      dateRange: '',
                      adults: 0,
                      location: '',
                      children: 0,
                    ));
          case '/view_booking':
            if (settings.arguments != null) {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => ViewMyBookingScreen(
                  dateRange: args['dateRange'],
                  adults: args['adults'],
                  location: args['location'],
                  children: args['children'],
                ),
              );
            }
            return MaterialPageRoute(
                builder: (context) => ViewMyBookingScreen(
                      dateRange: '',
                      adults: 0,
                      location: '',
                      children: 0,
                    ));
          case '/reviews':
            return MaterialPageRoute(builder: (context) => ReviewsScreen());
          case '/payment_success':
            if (settings.arguments != null) {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => PaymentSuccessScreen(
                  paymentMethod: args['paymentMethod'],
                  amount: args['amount'],
                  location: '',
                  dateRange: '',
                  adults: 0,
                  children: 0,
                ),
              );
            }
            return MaterialPageRoute(
                builder: (context) => PaymentSuccessScreen(
                      paymentMethod: '',
                      amount: 0,
                      location: '',
                      dateRange: '',
                      adults: 0,
                      children: 0,
                    ));
          case '/facilities':
            return MaterialPageRoute(builder: (context) => FacilitiesScreen());
          case '/location_details':
            return MaterialPageRoute(
                builder: (context) => const LocationDetailsScreen());
          case '/location_detail_view':
            return MaterialPageRoute(
                builder: (context) => LocationDetailsView());
          case '/description':
            return MaterialPageRoute(builder: (context) => DescriptionScreen());
          default:
            return null;
        }
      },
    );
  }
}
