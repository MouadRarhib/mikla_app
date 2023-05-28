import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mikla_project/Home/food_page_body.dart';
import 'package:mikla_project/Home/main_food_page.dart';
import 'package:mikla_project/controllers/cart_controller.dart';
import 'package:mikla_project/controllers/popular_product_controller.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_column.dart';
import 'package:mikla_project/widgets/app_icon.dart';
import 'package:mikla_project/widgets/exandable_text_widget.dart';
import 'package:mikla_project/pages/cart/cart_page.dart';

import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/icon_and_textwidgets.dart';
import '../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  final String page;
  PopularFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    // always we should use the controllers after using them
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    //print("page is id " + pageId.toString());
    //print("product name is " + product.name.toString());
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // ******************** to learn why *************************
        children: [
          //first image
          Positioned(
              //************* to learn *************
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimenssions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),

          Positioned(
            top: Dimenssions.height45,
            left: Dimenssions.width20,
            right: Dimenssions.height20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == "cartpage") {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    size: 40,
                  ),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          GestureDetector(
                            child: AppIcon(
                              icon: Icons.shopping_cart_checkout_outlined,
                              size: 40,
                            ),
                          ),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Positioned(
              left: 0,
              right: 0,
              top: Dimenssions.popularFoodImgSize - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimenssions.width20,
                      right: Dimenssions.width30,
                      top: Dimenssions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimenssions.radius20),
                          topLeft: Radius.circular(Dimenssions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimenssions.height20,
                      ),
                      BigText(text: "Description"),
                      SizedBox(
                        height: Dimenssions.height20,
                      ),
                      SingleChildScrollView(
                          child: ExpandableTextWidget(
                        text: product.description!,
                      )),
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
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
            child: Row(
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
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimenssions.width10 / 2,
                        ),
                        BigText(text: popularProduct.inCartItems.toString()),
                        SizedBox(
                          width: Dimenssions.width10 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimenssions.height20 / 2,
                          bottom: Dimenssions.height20 / 2,
                          left: Dimenssions.width20,
                          right: Dimenssions.width20),
                      child: BigText(
                          text: "\$ ${product.price!}| Add to cart",
                          color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimenssions.radius20),
                          color: AppColors.mainColor),
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
