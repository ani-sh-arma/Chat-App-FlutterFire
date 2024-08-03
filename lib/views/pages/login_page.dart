import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'register_page.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key}) {
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40.0),
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
                const SizedBox(height: 40.0),
                CustomButton(
                  onPressed: () async {
                    final email = emailController.text;
                    final password = passwordController.text;

                    try {
                      final userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      User? user = userCredential.user;

                      if (user != null) {
                        Get.off(HomeScreen());
                        // Get.to(HomeScreen());
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-credential') {
                        Get.snackbar("Error", "Invalid Credentials.");
                      } else {
                        Get.snackbar("Error", "Something went wrong");
                      }
                    }
                  },
                  text: "Login",
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    // Navigate to the signup screen
                    Get.to(RegisterScreen());
                  },
                  child: const Text(
                    'Don\'t have an account? Sign Up',
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
