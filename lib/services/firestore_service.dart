import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(
    String uid,
    String email,
    String name,
    String role,
    String birthdate,
    String gender,
    String province,
    String regency,
    String phoneNumber,
    String profileImageUrl,
  ) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'birthdate': birthdate,
      'province': province,
      'regency': regency,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
    });
  }

  Future<String?> getUserName(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists && userDoc.data() != null) {
      return userDoc['name'];
    } else {
      return null;
    }
  }

  Future<String?> getUserPhoto(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists && userDoc.data() != null) {
      return userDoc['profileImageUrl'];
    } else {
      return null;
    }
  }
}
