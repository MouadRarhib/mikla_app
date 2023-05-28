import 'package:flutter/material.dart';
import 'package:mikla_project/controllers/cart_controller.dart';
import 'package:mikla_project/controllers/popular_product_controller.dart';
import 'package:mikla_project/controllers/recommended_product_controller.dart';
import 'package:mikla_project/data/api/Api_client.dart';
import 'package:mikla_project/data/repository/popular_product_repo.dart';
import 'package:mikla_project/models/popular_products_model.dart';
import 'package:mikla_project/pages/auth/sign_up_page.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/splash/splash_page.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:mikla_project/widgets/app_column.dart';
import 'Home/food_page_body.dart';
import 'Home/main_food_page.dart';
import 'package:get/get.dart';

import 'food/popular_food_detail.dart';
import 'food/recommended_food_detail.dart';
import 'helper/dependencies.dart' as dep;
import 'pages/auth/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /* Get.lazyPut(() => ApiClient(
        appBaseUrl: "baseUrl", sharedPreferences: );*/
    Get.find<CartController>()
        .getCartData(); // we do this for getting data when we start the app
    // ignore: prefer_const_constructors
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            // home: SignInPage(),
            // home: SplashScreen(),
            //  home: MainFoodPage(),
            initialRoute: RouteHelper
                .getSplashPage(), // we used this to return in the home page
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
