import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';
import 'package:myproject/controllers/browsecontroller.dart';

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

          // Category list (NOW USING CONTROLLER)
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
                    onTap: () {
                      // Future: open category
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
