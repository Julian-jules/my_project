import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoritesController extends GetxController {
  var favorites = <Map<String, dynamic>>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  // ✅ Load favorites from storage when app starts
  void loadFavorites() {
    final stored = box.read<List>("favorites");
    if (stored != null) {
      favorites.value = stored.map((e) => Map<String, dynamic>.from(e)).toList();
    }
  }

  // ✅ Save favorites to storage every time they change
  void saveFavorites() {
    box.write("favorites", favorites.toList());
  }

  void toggleFavorite(Map<String, dynamic> item) {
    if (isFavorite(item)) {
      favorites.removeWhere((fav) => fav["name"] == item["name"]);
    } else {
      favorites.add(item);
    }
    saveFavorites(); // ✅ Save after every change
  }

  bool isFavorite(Map<String, dynamic> item) {
    return favorites.any((fav) => fav["name"] == item["name"]);
  }
}