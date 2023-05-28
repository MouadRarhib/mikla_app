import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/controllers/popular_product_controller.dart';
import 'package:mikla_project/controllers/recommended_product_controller.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/big_text.dart';
import 'package:mikla_project/widgets/small_text.dart';

import '../utils/colors.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    var index;
    return RefreshIndicator(
        child: Column(
          children: [
            //showing the header
            Container(
              margin: EdgeInsets.only(
                  top: Dimenssions.height45, bottom: Dimenssions.height15),
              padding: EdgeInsets.only(
                  left: Dimenssions.width20, right: Dimenssions.width20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "United states",
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Florida",
                              color: AppColors.mainBlackcolor,
                            ),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            width: Dimenssions.width45,
                            height: Dimenssions.height45,
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: Dimenssions.iconSize24,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimenssions.radius15),
                              // ignore: prefer_const_constructors
                              color: Color(0xFF69c5df),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // showing the body
            // Expanded -----> to learn
            Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(),
            ))
          ],
        ),
        onRefresh: _loadResource);
  }
}
