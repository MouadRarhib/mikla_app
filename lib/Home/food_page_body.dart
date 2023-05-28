//import 'dart:ffi';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mikla_project/controllers/popular_product_controller.dart';
import 'package:mikla_project/controllers/recommended_product_controller.dart';
import 'package:mikla_project/food/popular_food_detail.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_column.dart';
import 'package:mikla_project/widgets/big_text.dart';
import 'package:mikla_project/widgets/icon_and_textwidgets.dart';
import 'package:mikla_project/widgets/small_text.dart';
import 'package:get/get.dart';

import '../models/popular_products_model.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimenssions.pageViewContainer;
// to show index of the pages
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        //print("Current value is" + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoaded
                ? Container(
                    // showing products in the header
                    //color: Colors.red,
                    height: Dimenssions.pageView,

                    child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      },
                    ),
                  )
                : CircularProgressIndicator(
                    // showing the backend of the product (border radius)
                    color: AppColors.mainColor,
                  );
          },
        ),

        // showing the number of products page in the DotsIndicator
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                color: Colors.black87, // Inactive color
                activeColor: AppColors.iconColor2,
              ),
            );
          },
        ),
        //popular txt
        SizedBox(
          height: Dimenssions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimenssions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimenssions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimenssions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
        // list of food and images
        // recommended food
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct
                  .isLoaded // isLoaded for the download of the products
              ? ListView.builder(
                  // list of the products
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index, ""));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimenssions.width20,
                            right: Dimenssions.width20,
                            bottom: Dimenssions.height10),
                        child: Row(
                          children: [
                            // images sections
                            Container(
                              width: Dimenssions.listViewImgSize,
                              height: Dimenssions.listViewImgSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      // the border radius for the form of the images in the list recommended
                                      Dimenssions.radius30),
                                  color: Colors.white30,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        recommendedProduct
                                            .recommendedProductList[index]
                                            .img!),
                                  )),
                            ),
                            // text container
                            Expanded(
                              child: Container(
                                height: Dimenssions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimenssions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimenssions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimenssions.width10,
                                      right: Dimenssions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!),
                                      SizedBox(
                                        height: Dimenssions.height10,
                                      ),
                                      SmallText(
                                        text: "Width chinese characteristics",
                                        color: AppColors.mainBlackcolor,
                                      ),
                                      SizedBox(
                                        height: Dimenssions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time,
                                              text: "32min",
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4
        .identity(); // method for the changement of the products in the popular
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor / 2), 1);
    }

    // i used stack because its take the height of the first container
    return Transform(
      // for using matrix we should use Widget Transform for intialis the matrix
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimenssions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimenssions.width10, right: Dimenssions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenssions.radius30),
                  color: Color(0xFF69c5df),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProduct.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimenssions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimenssions.width30,
                  right: Dimenssions.width30,
                  bottom: Dimenssions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenssions.radius20),
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimenssions.height15,
                    left: Dimenssions.height15,
                    right: Dimenssions.height15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
