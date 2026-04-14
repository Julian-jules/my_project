import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryController extends GetxController {
  var products = [].obs;
  var isLoading = false.obs;
  var categoryName = "".obs;

  Future<void> fetchProductsByCategory(String category) async {
    isLoading.value = true;
    categoryName.value = category;
    products.clear();

    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost/my_project/get_products_by_category.php?category=$category"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == "success") {
          products.value = data["products"];
        }
      }
    } catch (e) {
      print("Error fetching category products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}