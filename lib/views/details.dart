import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';
import 'package:myproject/controllers/cartcontroller.dart';
import 'package:myproject/controllers/favoritecontroller.dart';
import 'package:myproject/views/cart.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final String image;

  const DetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://localhost/my_project/$image";
    final cartController = Get.put(CartController());
    final favController = Get.find<FavoritesController>();

    final item = {
      "name": name,
      "price": price,
      "description": description,
      "image": image,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: primaryColor,
        actions: [
          // ✅ Cart icon with badge
          Obx(() => Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Get.to(() => const CartScreen()),
                  ),
                  if (cartController.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${cartController.totalItems}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              )),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 280,
                  child: Center(
                    child: Icon(Icons.image_not_supported, size: 60),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ❤️ Favorite button
                      Obx(() {
                        final isFav = favController.isFavorite(item);
                        return IconButton(
                          onPressed: () => favController.toggleFavorite(item),
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 28,
                          ),
                        );
                      }),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    "\$ $price",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),

                  const SizedBox(height: 30),

                  // ✅ Add to Cart Button
                  Obx(() {
                    final inCart = cartController.isInCart(item);
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: inCart ? Colors.grey : primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: inCart
                            ? () => Get.to(() => const CartScreen())
                            : () => cartController.addToCart(item),
                        icon: Icon(
                          inCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        label: Text(
                          inCart ? "View in Cart" : "Add to Cart",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}