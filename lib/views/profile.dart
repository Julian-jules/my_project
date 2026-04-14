import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myproject/config/colors.dart';
import 'package:get/get.dart';
import 'package:myproject/controllers/profilecontroller.dart';
import 'package:myproject/views/browse.dart';
import 'package:myproject/views/favorites.dart';
import 'package:myproject/views/homescreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final TextEditingController usernameEditController = TextEditingController();

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
          ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const SizedBox(height: 30),

              // Profile Picture
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/crotchet_logo.jpg"),
                ),
              ),
              const SizedBox(height: 15),

              // ✅ Welcome back message
              Obx(() => Center(
                    child: Text(
                      "Welcome back, ${controller.username.value} 👋",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )),
              const SizedBox(height: 6),

              // Email
              Obx(() => Center(
                    child: Text(
                      controller.email.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  )),

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

              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  profileStat("Saved", "12"),
                  profileStat("Designs", "5"),
                  profileStat("Followers", "34"),
                ],
              ),
              const SizedBox(height: 30),

              // ✅ Edit Username section
              Obx(() {
                if (controller.isEditing.value) {
                  usernameEditController.text = controller.username.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        TextField(
                          controller: usernameEditController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "New Nickname",
                            labelStyle:
                                const TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => controller.updateUsername(
                                    usernameEditController.text.trim()),
                                child: Obx(() => controller.isLoading.value
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text("Save")),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white24,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () =>
                                    controller.isEditing.value = false,
                                child: const Text("Cancel",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                // ✅ Edit Profile Button
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () => controller.isEditing.value = true,
                    child: const Text("✏️ Edit Nickname"),
                  ),
                );
              }),

              const SizedBox(height: 15),

              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () => controller.logout(),
                  child: const Text("Log Out"),
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        buttonBackgroundColor: secondaryColor,
        height: 50,
        index: 3,
        items: const [
          Icon(Icons.home, color: Colors.white, size: 20),
          Icon(Icons.search, color: Colors.white, size: 20),
          Icon(Icons.favorite, color: Colors.white, size: 20),
          Icon(Icons.person, color: Colors.white, size: 20),
        ],
        onTap: (index) {
          if (index == 0) Get.off(() => const Homescreen());
          if (index == 1) Get.off(() => const BrowseScreen());
          if (index == 2) Get.off(() => const FavoritesScreen());
          if (index == 3) return;
        },
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