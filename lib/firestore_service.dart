import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveBooking({
    required String userId,
    required String location,
    required String dateRange,
    required int adults,
    required int children,
    required double totalAmount,
    required String firstName,
  }) async {
    try {
      await _db.collection('bookings').add({
        'userId': userId,
        'location': location,
        'dateRange': dateRange,
        'adults': adults,
        'children': children,
        'totalAmount': totalAmount,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving booking: $e');
    }
  }

  // Update profile picture only
  Future<void> updateProfilePicture(String url) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _db.collection('users').doc(user.uid).update({
        'profilePicture': url,
      });
    }
  }

  // Get profile picture URL
  Future<String?> getProfilePicture() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
      return (doc.data() as Map<String, dynamic>)['profilePicture'] as String?;
    }
    return null;
  }

  // Get user's first name
  Future<String?> getFirstName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
      return (doc.data() as Map<String, dynamic>)['firstName'] as String?;
    }
    return null;
  }

  getUserById(String uid) {}
}
