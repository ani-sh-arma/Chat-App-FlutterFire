import 'package:chat_app/views/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterScreen({super.key}) {
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in, navigate to the home page or another appropriate page
      Get.offAll(() =>
          HomeScreen()); // Use Get.offAll to replace the entire navigation stack
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40.0),
                CustomInputField(
                  controller: fullNameController,
                  labelText: 'Full Name',
                  icon: Icons.person,
                  obscureText: false,
                ),
                const SizedBox(height: 20.0),
                CustomInputField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  icon: Icons.email,
                  obscureText: false,
                ),
                const SizedBox(height: 20.0),
                CustomInputField(
                  controller: passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                CustomInputField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 40.0),
                CustomButton(
                  onPressed: () async {
                    final fullName = fullNameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;
                    final confirmPassword = confirmPasswordController.text;

                    try {
                      if (password == confirmPassword) {
                        if (password.length >= 8) {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          User? user = userCredential.user;

                          if (user != null) {
                            // Save additional user data in Firestore
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .set({
                              'fullName': fullName,
                              'email': email,
                              'createdAt': Timestamp.now(),
                            });
                          }
                          Get.to(LoginScreen());
                        } else {
                          Get.snackbar("Error",
                              "Password must be at least 8 characters long");
                          passwordController.clear();
                          confirmPasswordController.clear();
                        }
                      } else {
                        Get.snackbar("Error", "Passwords do not match");
                        passwordController.clear();
                        confirmPasswordController.clear();
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'email-already-in-use') {
                        Get.snackbar("Error", "Email already in use");
                      } else if (e.code == 'invalid-email') {
                        Get.snackbar("Error", "Invalid Email");
                      } else {
                        Get.snackbar("Error", "Something went wrong ${e.code}");
                      }
                    }
                  },
                  text: 'Register',
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login screen
                    Get.to(LoginScreen());
                  },
                  child: const Text(
                    'Already have an account? Log In.',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
