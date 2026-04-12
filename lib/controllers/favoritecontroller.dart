import 'package:get/get.dart';

class FavoritesController extends GetxController {
  // ✅ FIX: allow dynamic values
  var favorites = <Map<String, dynamic>>[].obs;

  void toggleFavorite(Map<String, dynamic> item) {
    if (isFavorite(item)) {
      favorites.removeWhere((fav) => fav["name"] == item["name"]);
    } else {
      favorites.add(item);
    }
  }

  bool isFavorite(Map<String, dynamic> item) {
    return favorites.any((fav) => fav["name"] == item["name"]);
  }
}