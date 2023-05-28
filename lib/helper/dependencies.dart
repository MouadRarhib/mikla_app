import 'package:get/get.dart';
import 'package:mikla_project/controllers/auth_controller.dart';
import 'package:mikla_project/controllers/cart_controller.dart';
import 'package:mikla_project/controllers/popular_product_controller.dart';
import 'package:mikla_project/controllers/recommended_product_controller.dart';
import 'package:mikla_project/controllers/user_controller.dart';
import 'package:mikla_project/data/api/Api_client.dart';
import 'package:mikla_project/data/repository/auth_repo.dart';
import 'package:mikla_project/data/repository/cart_repo.dart';

import 'package:mikla_project/data/repository/popular_product_repo.dart';
import 'package:mikla_project/data/repository/recommended_product_repo.dart';
import 'package:mikla_project/data/repository/user_repo.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
