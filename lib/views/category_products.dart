import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';
import 'package:myproject/controllers/categorycontroller.dart';
import 'package:myproject/controllers/favoritecontroller.dart';
import 'package:myproject/views/details.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;
  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    final favController = Get.find<FavoritesController>();

    // Fetch products when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductsByCategory(category);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("$category 🧶"),
        backgroundColor: primaryColor,
      ),

      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrao.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withAlpha(77)),

          // Products
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.products.isEmpty) {
              return Center(
                child: Text(
                  "No $category products yet 😔",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = controller.products[index];
                final imageUrl =
                    "http://localhost/my_project/${item["image"]}";

                return GestureDetector(
                  onTap: () {
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
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
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

                        // ❤️ Favorite Button
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Obx(() {
                            final isFav = favController.isFavorite(item);
                            return GestureDetector(
                              onTap: () =>
                                  favController.toggleFavorite(item),
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
          }),
        ],
      ),
    );
  }
}