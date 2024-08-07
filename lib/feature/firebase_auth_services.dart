// ignore_for_file: prefer_final_fields, unused_local_variable, body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String firstName, String lastName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Exception: ${e.message}");
      if (e.code == 'network-request-failed') {
        print("Check your internet connection and try again.");
      } else {
        print(e.message);
      }
    } catch (e) {
      print("An unexpected error occurred: $e");
    }
    return null;
  }

  Future<void> updateUserPhoneNumber(String userId, String phone) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'phone': phone,
      }, SetOptions(merge: true));
      print("Phone number updated successfully");
    } catch (e) {
      print("Error updating phone number: $e");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Error occurred: $e");
    }
    return null;
  }

  // Google Sign-In
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'firstName': googleUser.displayName?.split(' ')[0],
            'lastName': googleUser.displayName?.split(' ').last,
            'email': googleUser.email,
            'photoUrl': googleUser.photoUrl,
            'signInMethod': 'google',
            'createdAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }

        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Exception: ${e.message}");
    } on Exception catch (e) {
      print("General Exception: $e");
    }
    return null;
  }

  // Facebook Sign-In
  Future<User?> signInWithFacebook() async {
    try {
      // Trigger the Facebook authentication flow
      final LoginResult result = await FacebookAuth.instance.login();

      switch (result.status) {
        case LoginStatus.success:
          // Obtain the auth details from the request
          final AccessToken accessToken = result.accessToken!;
          final OAuthCredential facebookCredential =
              FacebookAuthProvider.credential(accessToken.token);

          // Sign in to Firebase with the Facebook credential
          final UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookCredential);

          if (userCredential.user != null) {
            final userData = await FacebookAuth.instance.getUserData();
            await _firestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
              'firstName': userData['name']?.split(' ')[0],
              'lastName': userData['name']?.split(' ').last,
              'email': userData['email'],
              'photoUrl': userData['picture']['data']['url'],
              'signInMethod': 'facebook',
              'createdAt': FieldValue.serverTimestamp(),
            }, SetOptions(merge: true));
          }

          // Return the signed-in user
          return userCredential.user;

        case LoginStatus.cancelled:
          print("Facebook login was cancelled by the user.");
          break;

        case LoginStatus.failed:
          print("Facebook login failed: ${result.message}");
          break;

        default:
          print("Facebook login status: ${result.status}");
          break;
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Exception: ${e.message}");
    } catch (e) {
      print("General Exception: $e");
    }
    return null;
  }

  // Apple Sign-In
  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'firstName': appleCredential.givenName,
          'lastName': appleCredential.familyName,
          'email': appleCredential.email,
          'signInMethod': 'apple',
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return userCredential.user;
    } catch (e) {
      print("Error signing in with Apple: $e");
      return null;
    }
  }
}
