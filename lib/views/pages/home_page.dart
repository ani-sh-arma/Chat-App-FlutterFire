import 'package:chat_app/controllers/home_controller.dart';
import 'package:chat_app/views/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Users'),
            IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Get.to(LoginScreen());
                } catch (e) {
                  Get.snackbar("Erro", "Failed to Sign Out");
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
                title: Text(user.fullName),
                onTap: () {
                  // Navigate to chat screen or user details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(user: user),
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
}
