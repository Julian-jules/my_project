import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';
import 'package:myproject/controllers/homescreencontroller.dart';
import 'package:myproject/controllers/favoritecontroller.dart';
import 'package:myproject/views/browse.dart';
import 'package:myproject/views/favorites.dart';
import 'package:myproject/views/profile.dart';
import 'details.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final HomeController controller = Get.put(HomeController());
  final FavoritesController favController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Julian's Crochet Studio 🧶"),
        backgroundColor: primaryColor,
      ),

      body: Stack(
        children: [
          /// 🌸 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrao.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Dark overlay
          Container(color: Colors.black.withAlpha(80)),

          /// Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Text(
                    "WHAT WE OFFER 💖",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                /// 🧶 Products Grid
                Expanded(
                  child: Obx(
                    () {
                      if (controller.items.isEmpty) {
                        return const Center(
                          child: Text(
                            "No products available",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return GridView.builder(
                        itemCount: controller.items.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.items[index];

                          return GestureDetector(
                            onTap: () {
                              /// 🔥 Navigate to Detail Page
                              Get.to(() => DetailPage(
                                    name: item["name"] ?? "No name",
                                    price: item["price"] ?? "0",
                                    description:
                                        item["description"] ?? "No description",
                                    image: item["image"] ?? "",
                                  ));
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),

                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      /// 🖼 Image
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(15),
                                          ),
                                          child: Image.asset(
                                            item["image"] ?? "",
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.image_not_supported,
                                                size: 50,
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                      /// 🏷 Name
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          item["name"] ?? "No name",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// ❤️ Favorite Button
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Obx(() {
                                      final isFav =
                                          favController.isFavorite(item);

                                      return GestureDetector(
                                        onTap: () {
                                          favController.toggleFavorite(item);
                                        },
                                        child: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                          size: 28,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// 🔻 Bottom Navigation
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        buttonBackgroundColor: secondaryColor,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (index) {
          if (index == 0) return;

          if (index == 1) {
            Get.off(() => const BrowseScreen());
          }

          if (index == 2) {
            Get.off(() => const FavoritesScreen());
          }

          if (index == 3) {
            Get.off(() => const ProfileScreen());
          }
        },
      ),
    );
  }
}