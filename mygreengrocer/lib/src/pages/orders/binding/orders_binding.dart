import 'package:get/get.dart';
import 'package:mygreengrocer/src/pages/orders/controller/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }
}
