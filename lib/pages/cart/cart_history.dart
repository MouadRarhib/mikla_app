import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:mikla_project/base/no_data_page.dart';
import 'package:mikla_project/controllers/cart_controller.dart';
import 'package:mikla_project/models/cart_model.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_icon.dart';
import 'package:mikla_project/widgets/big_text.dart';
import 'package:mikla_project/widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartitemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartitemsPerOrderToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimenssions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  size: 40,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimenssions.font20,
                          left: Dimenssions.width20,
                          right: Dimenssions.width20),
                      child: MediaQuery.removePadding(
                        // we use mediaquery.removepadding for removing the space in the top
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimenssions.height10 * 15,
                                margin: EdgeInsets.only(
                                    bottom: Dimenssions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimenssions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                itemsPerOrder[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Dimenssions.height20 *
                                                              4,
                                                      width:
                                                          Dimenssions.height20 *
                                                              4,
                                                      margin: EdgeInsets.only(
                                                          right: Dimenssions
                                                                  .width10 /
                                                              2),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimenssions
                                                                      .radius15 /
                                                                  2),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(AppConstants
                                                                      .BASE_URL +
                                                                  AppConstants
                                                                      .UPLOAD_URL +
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!))),
                                                    )
                                                  : Container();
                                            })),
                                        Container(
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SmallText(
                                                text: "Total",
                                                color: AppColors.titlecolor,
                                              ),
                                              BigText(
                                                text: itemsPerOrder[i]
                                                        .toString() +
                                                    "Items",
                                                color: AppColors.titlecolor,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(
                                                                  jsonEncode(
                                                                      // we uded jsonDecode anf jsonEncode because of the err
                                                                      getCartHistoryList[
                                                                          j]))));
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addtoCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimenssions.width10,
                                                      vertical:
                                                          Dimenssions.height10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimenssions
                                                                    .height15 /
                                                                2),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                  child: SmallText(
                                                    text: "one more",
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(child: NoDataPage()));
          })
        ],
      ),
    );
  }
}
