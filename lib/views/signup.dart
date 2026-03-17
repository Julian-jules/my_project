import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';

const Color primaryColor = Color(0xFFB76E79); // crochet pink

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 238, 244),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            /// Crochet Logo
            Image.asset("assets/crotchet_logo.jpg", width: 80),

            const SizedBox(height: 10),

            /// Title
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),

            const SizedBox(height: 30),

            /// Full Name
            TextField(
              decoration: InputDecoration(
                hintText: "Full Name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Email
            TextField(
              decoration: InputDecoration(
                hintText: "Email or Phone Number",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Confirm Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Sign Up Button
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            /// Login text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Get.offNamed("/login");
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
