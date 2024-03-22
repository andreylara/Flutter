import 'package:get/get.dart';
import 'package:mygreengrocer/src/models/category_model.dart';
import 'package:mygreengrocer/src/models/item_model.dart';
import 'package:mygreengrocer/src/pages/home/repository/home_repository.dart';
import 'package:mygreengrocer/src/pages/home/result/home_result.dart';
import 'package:mygreengrocer/src/services/utils_services.dart';

const itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  final utilsServices = UtilsServices();

  //variação do obs = getbuilder
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  CategoryModel? currencyCategory;
  List<ItemModel> get allProducts => currencyCategory?.items ?? [];

  RxString searchTitle = ''.obs;

  bool get isLastPage {
    if (currencyCategory!.items.length < itemsPerPage) return true;
    return currencyCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();

    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currencyCategory = category;
    update();

    if (currencyCategory!.items.isNotEmpty) return;

    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      sucess: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        selectCategory(allCategories.first);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  void filterByTitle() {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == '');

      if (c == null) {
        //Criar nova categoria todos
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );
        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currencyCategory = allCategories.first;

    update();

    getAllProducts();
  }

  void loadMoreProducts() {
    currencyCategory!.pagination++;

    getAllProducts(canLoad: false);
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currencyCategory!.pagination,
      'categoryId': currencyCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (currencyCategory!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> homeResult =
        await homeRepository.getAllProducts(body);

    setLoading(false, isProduct: true);

    homeResult.when(
      sucess: (data) {
        currencyCategory!.items.addAll(data);
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
