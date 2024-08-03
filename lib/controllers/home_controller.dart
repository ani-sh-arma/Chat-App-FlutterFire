import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/local_user.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<LocalUser> users = <LocalUser>[].obs;
  RxString errorMessage = ''.obs;

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      users.value = snapshot.docs.map((doc) => LocalUser.fromDocument(doc)).toList();
    } catch (e) {
      errorMessage.value = 'Failed to fetch users: $e';
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }
}
