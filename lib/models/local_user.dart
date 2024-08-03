import 'package:cloud_firestore/cloud_firestore.dart';

class LocalUser {
  final String uid;
  final String fullName;
  final String email;

  LocalUser({
    required this.uid,
    required this.fullName,
    required this.email,
  });
  factory LocalUser.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LocalUser(
      uid: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
