import 'package:flutter/material.dart';
import 'package:mygreengrocer/src/config/custom_colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mygreengrocer/src/pages/common_widgets/custom_shimmer.dart';
import 'package:mygreengrocer/src/pages/home/components/category_tile.dart';
import 'package:mygreengrocer/src/config/app_data.dart' as app_data;
import 'package:mygreengrocer/src/pages/home/components/item_tile.dart';

import '../common_widgets/app_name_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

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
            child: GestureDetector(
              onTap: () {},
              child: badges.Badge(
                badgeContent: const Text(
                  '2',
                  style: TextStyle(
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
            ),
          )
        ],
      ),

      body: Column(
        children: [
          //Campo pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),

          //Categorias
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: !isLoading
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return CategoryTile(
                        onPressed: () {
                          setState(() {
                            selectedCategory = app_data.categories[index];
                          });
                        },
                        category: app_data.categories[index],
                        isSelected:
                            app_data.categories[index] == selectedCategory,
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(width: 10),
                    itemCount: app_data.categories.length,
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
          ),

          //Grid
          Expanded(
            child: !isLoading
                ? GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                    ),
                    itemCount: app_data.items.length,
                    itemBuilder: (_, index) {
                      return ItemTile(
                        item: app_data.items[index],
                      );
                    },
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
          ),
        ],
      ),
    );
  }
}
