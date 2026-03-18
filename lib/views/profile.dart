import 'package:flutter/material.dart';
import 'package:myproject/config/colors.dart';
import 'package:get/get.dart';
import 'package:myproject/views/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile 👤"),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrao.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withAlpha(77)),

          // Profile Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),

                // Profile Picture
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    "assets/crotchet_logo.jpg",
                  ), // replace with user profile pic
                ),
                const SizedBox(height: 15),

                // Username
                const Text(
                  "Crochet Lover",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Bio
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Sharing my love for yarn and crochet creations 🧶",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(179, 254, 253, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Stats (Optional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    profileStat("Saved", "12"),
                    profileStat("Designs", "5"),
                    profileStat("Followers", "34"),
                  ],
                ),
                const SizedBox(height: 30),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {},
                    child: const Text("Edit Profile"),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {},
                    child: const Text("Log Out"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileStat(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
