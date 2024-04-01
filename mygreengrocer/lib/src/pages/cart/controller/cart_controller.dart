import 'package:get/get.dart';
import 'package:mygreengrocer/src/models/cart_item_model.dart';
import 'package:mygreengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:mygreengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:mygreengrocer/src/pages/cart/result/cart_result.dart';
import 'package:mygreengrocer/src/services/utils_services.dart';

import '../../../models/item_model.dart';

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

  Future<bool> modifyItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.modifyItemQuantity(
      token: authController.user.token!,
      carItemId: item.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
      update();
    } else {
      utilsServices.showToast(
        message: 'Ocorreu um erro ao alterar a quantidade do produto',
        isError: true,
      );
    }

    return result;
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

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      //Existe

      final product = cartItems[itemIndex];
      await modifyItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      //Não Existe
      final CartResult<String> result = await cartRepository.addItemToCart(
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );
      result.when(
        sucess: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilsServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }
    update();
  }
}
