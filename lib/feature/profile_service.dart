import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> changeProfilePicture() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      try {
        String filePath = 'profile_pictures/${user.uid}.png';
        await _storage.ref(filePath).putFile(file);
        String photoUrl = await _storage.ref(filePath).getDownloadURL();

        await _firestore.collection('users').doc(user.uid).update({
          'photoUrl': photoUrl,
        });

        await user.updatePhotoURL(photoUrl);
      } catch (e) {
        print('Failed to upload profile picture: $e');
      }
    }
  }
}
