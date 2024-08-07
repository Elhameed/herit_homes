import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_service.dart'; // Import the ProfileService

class ProfileMenuWidget extends StatelessWidget {
  final User? user;
  final void Function() onLogout;
  final void Function() onDeleteAccount;

  ProfileMenuWidget({
    required this.user,
    required this.onLogout,
    required this.onDeleteAccount,
  });

  Stream<Map<String, dynamic>> _userDetailsStream() {
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots()
          .map((doc) => doc.data() as Map<String, dynamic>);
    } else {
      return Stream.value({});
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _userDetailsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching user details'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          final userFirstName = data['firstName'] ?? 'User';
          final userPhotoUrl = data['profilePicture'];

          return PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  title: Text('Dear $userFirstName!',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: GestureDetector(
                    onTap: () async {
                      final profileService = ProfileService();
                      await profileService.changeProfilePicture();
                      // No need to manually refresh the UI; StreamBuilder will handle it
                      Navigator.of(context).pop(); // Close the menu
                    },
                    child: CircleAvatar(
                      backgroundImage: userPhotoUrl != null
                          ? NetworkImage(userPhotoUrl!)
                          : AssetImage('assets/default_user.png')
                              as ImageProvider,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text('Continue'),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the menu
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text('Logout'),
                  onTap: onLogout,
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text('Delete account',
                      style: TextStyle(color: Colors.red)),
                  onTap: onDeleteAccount,
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('No user details found'));
        }
      },
    );
  }
}
