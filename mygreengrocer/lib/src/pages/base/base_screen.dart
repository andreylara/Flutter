import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreengrocer/src/pages/base/controller/navigation_controller.dart';
import 'package:mygreengrocer/src/pages/cart/cart_tab.dart';
import 'package:mygreengrocer/src/pages/home/home_tab.dart';
import 'package:mygreengrocer/src/pages/orders/orders_tab.dart';

import '../profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();

  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: const [
          HomeTab(),
          CarTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: navigationController.currentIndex,
            onTap: (index) {
              navigationController.navigatePageView(index);
              //pageController.animateToPage(
              // index,
              //  duration: const Duration(milliseconds: 700),
              //  curve: Curves.ease,
              //);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(100),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Carrinho',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Pedidos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
              )
            ]),
      ),
    );
  }
}
