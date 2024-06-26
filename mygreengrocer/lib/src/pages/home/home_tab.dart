import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygreengrocer/src/config/custom_colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mygreengrocer/src/pages/base/controller/navigation_controller.dart';
import 'package:mygreengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:mygreengrocer/src/pages/common_widgets/custom_shimmer.dart';
import 'package:mygreengrocer/src/pages/home/controller/home_controller.dart';
import 'package:mygreengrocer/src/pages/home/view/components/category_tile.dart';
import 'package:mygreengrocer/src/pages/home/view/components/item_tile.dart';

import '../common_widgets/app_name_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final searchController = TextEditingController();
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 18,
              right: 15,
            ),
            child: GetBuilder<CartController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    navigationController.navigatePageView(NavigationTabs.cart);
                  },
                  child: badges.Badge(
                    badgeContent: Text(
                      controller.cartItems.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: CustomColors.customConstrastColor,
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: CustomColors.customSwatchColor,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),

      body: Column(
        children: [
          //Campo pesquisa
          GetBuilder<HomeController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    controller.searchTitle.value = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    hintText: 'Pesquise aqui...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: CustomColors.customConstrastColor,
                      size: 21,
                    ),
                    suffixIcon: controller.searchTitle.value.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();
                              controller.searchTitle.value = '';
                              FocusScope.of(context).unfocus();
                            },
                            icon: Icon(
                              Icons.close,
                              color: CustomColors.customConstrastColor,
                              size: 21,
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          //Categorias
          GetBuilder<HomeController>(
            builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                height: 40,
                child: !controller.isCategoryLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryTile(
                            onPressed: () {
                              controller.selectCategory(
                                  controller.allCategories[index]);
                            },
                            category: controller.allCategories[index].title,
                            isSelected: controller.allCategories[index] ==
                                controller.currencyCategory,
                          );
                        },
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10),
                        itemCount: controller.allCategories.length,
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          4,
                          (index) => Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 12),
                            child: CustomShimmer(
                              height: 20,
                              width: 80,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
              );
            },
          ),

          //Grid
          GetBuilder<HomeController>(
            builder: (controller) {
              return Expanded(
                child: !controller.isProductLoading
                    ? Visibility(
                        visible:
                            (controller.currencyCategory!.items).isNotEmpty,
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 40,
                              color: CustomColors.customSwatchColor,
                            ),
                            const Text('Não há itens para apresentar'),
                          ],
                        ),
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 9 / 11.5,
                          ),
                          itemCount: controller.allProducts.length,
                          itemBuilder: (_, index) {
                            if ((index + 1) == controller.allProducts.length &&
                                !controller.isLastPage) {
                              controller.loadMoreProducts();
                            }

                            return ItemTile(
                              item: controller.allProducts[index],
                            );
                          },
                        ),
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                        children: List.generate(
                          6,
                          (index) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
