import 'package:flutter/material.dart';
import 'package:myproject/config/colors.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  static const categories = [
    "Hats",
    "Bags",
    "Amigurumi",
    "Yarn",
    "Sweaters",
    "Baby Items",
  ];

  @override
  Widget build(BuildContext context) {
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

          // Semi-transparent overlay for readability
          Container(color: Colors.black.withAlpha(77)),

          // Category list
          ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: categories.length,
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
                    categories[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // TODO: Open category page or filter items
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
