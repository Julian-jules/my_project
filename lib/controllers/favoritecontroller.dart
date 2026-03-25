import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var favorites = <Map<String, String>>[].obs;

  void addToFavorites(Map<String, String> item) {
    favorites.add(item);
  }

  void removeFromFavorites(Map<String, String> item) {
    favorites.remove(item);
  }
}
