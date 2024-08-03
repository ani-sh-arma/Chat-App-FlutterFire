import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String fullName;
  final String email;

  User({
    required this.fullName,
    required this.email,
  });
  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
