import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(
    String uid,
    String email,
    String name,
    String birthdate,
    String gender,
    String province,
    String regency,
    String phoneNumber,
  ) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'birthdate': birthdate,
      'province': province,
      'regency': regency,
      'phoneNumber': phoneNumber,
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
}
