import 'package:get/get.dart';
import 'package:mygreengrocer/src/models/category_model.dart';
import 'package:mygreengrocer/src/pages/home/repository/home_repository.dart';
import 'package:mygreengrocer/src/pages/home/result/home_result.dart';
import 'package:mygreengrocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  final utilsServices = UtilsServices();

  //variação do obs = getbuilder
  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  CategoryModel? currencyCategory;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currencyCategory = category;
    update();
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
}
