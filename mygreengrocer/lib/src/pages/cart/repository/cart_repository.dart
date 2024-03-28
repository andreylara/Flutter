import 'package:mygreengrocer/src/constants/endponts.dart';
import 'package:mygreengrocer/src/models/cart_item_model.dart';
import 'package:mygreengrocer/src/pages/cart/result/cart_result.dart';
import 'package:mygreengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.sucess(data);
    } else {
      return CartResult.error(
          'Ocorreu um erro ao recuperar os itens do carrinho');
    }
  }
}
