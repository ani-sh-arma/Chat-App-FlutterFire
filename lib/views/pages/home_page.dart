import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'chat_screen.dart';
import 'login_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Welcome"),
            IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Get.to(LoginScreen());
                } catch (e) {
                  Get.snackbar("Error", "Failed to Sign Out");
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Obx(
          () => ListView.builder(
            itemCount: homeController.users.length,
            itemBuilder: (context, index) {
              final user = homeController.users[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/user-icon.png'),
                ),
                title: Text(
                  FirebaseAuth.instance.currentUser!.email == user.email
                      ? '${user.fullName} (You)'
                      : user.fullName,
                ),
                onTap: () {
                  Get.to(
                    () => ChatScreen(
                      user: FirebaseAuth.instance.currentUser!,
                      localUser: user,
                      chatId: generateChatId(
                        FirebaseAuth.instance.currentUser!.uid,
                        user.uid,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  String generateChatId(String userId1, String userId2) {
    // Ensure user IDs are in a consistent order
    final sortedIds = [userId1, userId2]..sort();
    return '${sortedIds[0]}_${sortedIds[1]}';
  }
}
