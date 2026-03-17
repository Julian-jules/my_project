import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myproject/config/colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, String>> items = [
    {"name": "Crochet Bag", "image": "assets/download.jpg"},
    {"name": "Amigurumi Toy", "image": "assets/doll.jpg"},
    {"name": "Crochet Hats", "image": "assets/hats.jpg"},
    {"name": "Crochet yarns", "image": "assets/background_crochet.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crochet Studio 🧶"),
        backgroundColor: primaryColor,
      ),

      body: Stack(
        children: [
          /// Background Image
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
          Container(color: Colors.black.withAlpha(77)),

          /// Crochet Grid
          Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: items.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),

              itemBuilder: (context, index) {
                final item = items[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),

                          child: Image.asset(
                            item["image"]!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          item["name"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        buttonBackgroundColor: secondaryColor,

        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.category, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],

        onTap: (index) {},
      ),
    );
  }
}
