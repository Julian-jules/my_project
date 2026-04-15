import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/controllers/homescreencontroller.dart';
import 'package:myproject/controllers/favoritecontroller.dart';
import 'package:myproject/views/details.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final favController = Get.find<FavoritesController>();

    return Stack(
      children: [
        // 🌸 Background with overlay
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrao.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),

        // 🌟 Main Content
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

              // 🧶 Products Grid
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.items.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products found",
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
                                      borderRadius:
                                          const BorderRadius.vertical(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}