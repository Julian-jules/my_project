import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);

      var response = await http.get(
        Uri.parse("http://localhost/my_project/get_products.php"),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data["status"] == "success") {
          items.value = List<Map<String, dynamic>>.from(data["data"]);
        }
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}

