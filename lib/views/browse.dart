import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';
import 'package:myproject/controllers/browsecontroller.dart';
import 'package:myproject/views/category_products.dart';
import 'package:myproject/views/favorites.dart';
import 'package:myproject/views/profile.dart';
import 'package:myproject/views/homescreen.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrowseController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Categories 🧶"),
        backgroundColor: primaryColor,
      ),

      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/colorful-crochet-flowers-pattern.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay
          Container(color: Colors.black.withAlpha(77)),

          // Category list
          Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white.withAlpha(220),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.category,
                      color: Colors.deepOrangeAccent,
                    ),
                    title: Text(
                      controller.categories[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // ✅ Navigate to category products screen
                      Get.to(() => CategoryProductsScreen(
                            category: controller.categories[index],
                          ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        buttonBackgroundColor: secondaryColor,
        height: 50,
        index: 1,
        items: const [
          Icon(Icons.home, color: Colors.white, size: 20),
          Icon(Icons.search, color: Colors.white, size: 20),
          Icon(Icons.favorite, color: Colors.white, size: 20),
          Icon(Icons.person, color: Colors.white, size: 20),
        ],
        onTap: (index) {
          if (index == 0) Get.off(() => const Homescreen());
          if (index == 1) return;
          if (index == 2) Get.off(() => const FavoritesScreen());
          if (index == 3) Get.off(() => const ProfileScreen());
        },
      ),
    );
  }
}