import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/Home/main_food_page.dart';
import 'package:mikla_project/base/no_data_page.dart';
import 'package:mikla_project/controllers/auth_controller.dart';
import 'package:mikla_project/controllers/cart_controller.dart';
import 'package:mikla_project/controllers/popular_product_controller.dart';
import 'package:mikla_project/controllers/recommended_product_controller.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_icon.dart';
import 'package:mikla_project/widgets/big_text.dart';
import 'package:mikla_project/widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimenssions.height20,
            top: Dimenssions.width20 * 2,
            right: Dimenssions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    size: 40,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                SizedBox(
                  width: Dimenssions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    size: 40,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  size: 40,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    left: Dimenssions.height20,
                    top: Dimenssions.width20 * 4,
                    right: Dimenssions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimenssions.height15),
                      //  color: Color.fromRGBO(244, 67, 54, 1),
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (CartController) {
                              var _cartList = CartController.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      height: 100,
                                      width: double.infinity,
                                      child: Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);

                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex, ""));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History product",
                                                    "Product review is not available for history product!",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex, ""));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimenssions.height20 * 5,
                                            height: Dimenssions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimenssions.height10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .UPLOAD_URL +
                                                          CartController
                                                              .getItems[index]
                                                              .img!)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimenssions.radius20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimenssions.width10,
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: Dimenssions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: CartController
                                                    .getItems[index].name!,
                                                color: Colors.black45,
                                              ),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: CartController
                                                            .getItems[index]
                                                            .price
                                                            .toString() +
                                                        "\$ ",
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimenssions
                                                                .height20 /
                                                            4,
                                                        bottom: Dimenssions
                                                                .height20 /
                                                            4,
                                                        left:
                                                            Dimenssions.width20,
                                                        right: Dimenssions
                                                            .width20),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimenssions
                                                                    .radius20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            CartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimenssions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity
                                                                .toString() //popularProduct.inCartItems.toString()
                                                            ),
                                                        SizedBox(
                                                          width: Dimenssions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            CartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ]),
                                    );
                                  });
                            },
                          )),
                    ))
                : NoDataPage();
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
              height: Dimenssions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimenssions.height30,
                  bottom: Dimenssions.height30,
                  right: Dimenssions.height30),
              decoration: BoxDecoration(
                  color: AppColors.buttonbackgroundcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimenssions.radius20 * 2),
                      topRight: Radius.circular(Dimenssions.radius20 * 2))),
              child: cartController.getItems.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: Dimenssions.height20 / 2,
                                bottom: Dimenssions.height20 / 2,
                                left: Dimenssions.width20,
                                right: Dimenssions.width20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimenssions.radius20),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Dimenssions.width10 / 2,
                                ),
                                BigText(
                                    text: "\$ " +
                                        cartController.totalAmount.toString()),
                                SizedBox(
                                  width: Dimenssions.width10 / 2,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                cartController.addToHistory();
                              } else {
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: Dimenssions.height20 / 2,
                                  bottom: Dimenssions.height20 / 2,
                                  left: Dimenssions.width20,
                                  right: Dimenssions.width20),
                              child: BigText(
                                  text: "Check out", color: Colors.white),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimenssions.radius20),
                                  color: AppColors.mainColor),
                            ),
                          ),
                        ])
                  : Container());
        },
      ),
    );
  }
}
