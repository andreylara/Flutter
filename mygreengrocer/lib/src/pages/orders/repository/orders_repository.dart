import 'package:mygreengrocer/src/constants/endponts.dart';
import 'package:mygreengrocer/src/models/cart_item_model.dart';
import 'package:mygreengrocer/src/models/order_model.dart';
import 'package:mygreengrocer/src/pages/orders/result/orders_result.dart';
import 'package:mygreengrocer/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<CartItemModel>>> getOrderItems({
    required String orderId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      body: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrdersResult<List<CartItemModel>>.sucess(items);
    } else {
      return OrdersResult.error(
          'Não foi possível recuperar os produtos do pedido');
    }
  }

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResult.sucess(orders);
    } else {
      return OrdersResult.error('Não foi possível recuperar os pedidos');
    }
  }
}
