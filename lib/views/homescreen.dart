import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/config/colors.dart';
import 'package:myproject/controllers/homescreencontroller.dart';
import 'package:myproject/controllers/favoritecontroller.dart';
import 'package:myproject/views/browse.dart';
import 'package:myproject/views/favorites.dart';
import 'package:myproject/views/profile.dart';
import 'home_body.dart';

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

      body: const HomeBody(),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        buttonBackgroundColor: secondaryColor,
        height: 50,
        index: 0,
        items: const [
          Icon(Icons.home, color: Colors.white, size: 20),
          Icon(Icons.search, color: Colors.white, size: 20),
          Icon(Icons.favorite, color: Colors.white, size: 20),
          Icon(Icons.person, color: Colors.white, size: 20),
        ],
        onTap: (index) {
          if (index == 0) return; // already here
          if (index == 1) Get.off(() => const BrowseScreen());
          if (index == 2) Get.off(() => const FavoritesScreen());
          if (index == 3) Get.off(() => const ProfileScreen());
        },
      ),
    );
  }
}