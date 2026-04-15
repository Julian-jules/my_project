import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    final stored = box.read<List>("cart");
    if (stored != null) {
      cartItems.value = stored.map((e) => Map<String, dynamic>.from(e)).toList();
    }
  }

  void saveCart() {
    box.write("cart", cartItems.toList());
  }

  void addToCart(Map<String, dynamic> item) {
    // Check if item already in cart
    final index = cartItems.indexWhere((c) => c["name"] == item["name"]);
    if (index != -1) {
      // Increase quantity
      cartItems[index] = {
        ...cartItems[index],
        "quantity": (cartItems[index]["quantity"] ?? 1) + 1,
      };
    } else {
      cartItems.add({...item, "quantity": 1});
    }
    saveCart();
    Get.snackbar(
      "Added to Cart 🛒",
      "${item["name"]} has been added to your cart",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void removeFromCart(Map<String, dynamic> item) {
    cartItems.removeWhere((c) => c["name"] == item["name"]);
    saveCart();
  }

  void increaseQuantity(Map<String, dynamic> item) {
    final index = cartItems.indexWhere((c) => c["name"] == item["name"]);
    if (index != -1) {
      cartItems[index] = {
        ...cartItems[index],
        "quantity": (cartItems[index]["quantity"] ?? 1) + 1,
      };
      saveCart();
    }
  }

  void decreaseQuantity(Map<String, dynamic> item) {
    final index = cartItems.indexWhere((c) => c["name"] == item["name"]);
    if (index != -1) {
      final currentQty = cartItems[index]["quantity"] ?? 1;
      if (currentQty <= 1) {
        removeFromCart(item);
      } else {
        cartItems[index] = {
          ...cartItems[index],
          "quantity": currentQty - 1,
        };
        saveCart();
      }
    }
  }

  bool isInCart(Map<String, dynamic> item) {
    return cartItems.any((c) => c["name"] == item["name"]);
  }

  // ✅ Total price
  double get totalPrice {
    return cartItems.fold(0, (sum, item) {
      final price = double.tryParse(item["price"].toString()) ?? 0;
      final qty = item["quantity"] ?? 1;
      return sum + (price * qty);
    });
  }

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + (item["quantity"] as int? ?? 1));
  }
}