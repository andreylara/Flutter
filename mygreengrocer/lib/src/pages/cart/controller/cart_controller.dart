import 'package:get/get.dart';
import 'package:mygreengrocer/src/models/cart_item_model.dart';
import 'package:mygreengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:mygreengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:mygreengrocer/src/pages/cart/result/cart_result.dart';
import 'package:mygreengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
    );

    result.when(
      sucess: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
