import 'package:get/get.dart';
import 'package:mikla_project/Home/home_page.dart';
import 'package:mikla_project/Home/main_food_page.dart';
import 'package:mikla_project/food/popular_food_detail.dart';
import 'package:mikla_project/food/recommended_food_detail.dart';
import 'package:mikla_project/pages/auth/sign_in_page.dart';
import 'package:mikla_project/pages/cart/cart_page.dart';
import 'package:mikla_project/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const popularFood = "/popular-Food";
  static const recommendedFood = "/recommended-Food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page'; // geting the Id number when u click in the product
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return HomePage();
        }),
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];

          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn // fadeIn for the animation of the page
        )
  ];
}
