import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/controllers/cart_controller.dart';
import 'package:mikla_project/controllers/popular_product_controller.dart';
import 'package:mikla_project/controllers/recommended_product_controller.dart';
import 'package:mikla_project/pages/cart/cart_page.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_icon.dart';
import 'package:mikla_project/widgets/big_text.dart';
import 'package:mikla_project/widgets/exandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommendedFoodDetail(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading:
                  false, // for delete the automatique icon
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear, size: 30),
                  ),
                  //AppIcon(icon: Icons.shopping_cart, size: 30)
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CartPage());
                            },
                            child: GestureDetector(
                              onTap: () {
                                if (controller.totalItems >= 1)
                                  Get.toNamed(RouteHelper.getCartPage());
                              },
                              child: AppIcon(
                                icon: Icons.shopping_cart_checkout_outlined,
                                size: 40,
                              ),
                            ),
                          ),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.getCartPage());
                                    },
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
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
                      );
                    },
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(child: BigText(text: product.name!)),
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimenssions.radius20),
                          topRight: Radius.circular(Dimenssions.radius20))),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              )),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExpandableTextWidget(text: product.description!),
                    margin: EdgeInsets.only(
                        left: Dimenssions.width20, right: Dimenssions.width20),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimenssions.width20 * 2.5,
                right: Dimenssions.width20 * 2.5,
                top: Dimenssions.height10,
                bottom: Dimenssions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimenssions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.remove,
                        size: 30),
                  ),
                  BigText(
                    text: "\$ ${product.price!} X ${controller.inCartItems} ",
                    color: AppColors.mainBlackcolor,
                    size: Dimenssions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimenssions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.add,
                        size: 30),
                  ),
                ],
              ),
            ),
            Row(
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
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                      size: 30,
                    )),
                GestureDetector(
                  onTap: () {
                    controller.addItem(product);
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
                )
              ],
            ),
          ]);
        }));
  }
}
