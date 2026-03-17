import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 30),

            /// Crochet Logo
            Image.asset("assets/crotchet_logo.jpg", width: 140),

            const SizedBox(height: 20),

            const Text(
              "Enter your email to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(color: primaryColor, fontSize: 18),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),

              child: TextField(
                controller: emailController,

                decoration: const InputDecoration(
                  labelText: "Email",

                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 176, 91, 91),
                  ),

                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: const Color.fromARGB(255, 107, 26, 26),
                ),

                onPressed: () {
                  String email = emailController.text;

                  if (email.isEmpty) {
                    Get.snackbar("Error", "Please enter your email");
                  } else {
                    Get.snackbar(
                      "Success",
                      "Password reset link sent to $email",
                    );
                  }
                },

                child: const Text("Send Reset Link"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
