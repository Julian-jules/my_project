import 'package:get/get.dart';

class FavoritesController extends GetxController {
  // Use .obs to make the list reactive so the UI updates automatically
  var favorites = <Map<String, String>>[].obs;

  // This is the missing method causing your error
  void toggleFavorite(Map<String, String> item) {
    if (favorites.contains(item)) {
      favorites.remove(item);
    } else {
      favorites.add(item);
    }
  }

  // This is the other missing method required by your homescreen.dart
  bool isFavorite(Map<String, String> item) {
    return favorites.contains(item);
  }
}
