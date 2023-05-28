import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mikla_project/base/custom_loader.dart';
import 'package:mikla_project/controllers/auth_controller.dart';
import 'package:mikla_project/controllers/cart_controller.dart';
import 'package:mikla_project/controllers/user_controller.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/Account_widgets.dart';
import 'package:mikla_project/widgets/app_icon.dart';
import 'package:mikla_project/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("done");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (UserController) {
          return _userLoggedIn
              ? (UserController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimenssions.height20),
                      child: Column(
                        children: [
                          // profile icon
                          AppIcon(
                            icon: Icons.person,
                            size: Dimenssions.height15 * 10,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize:
                                Dimenssions.height45 + Dimenssions.height30,
                          ),
                          SizedBox(
                            height: Dimenssions.height30,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        size: Dimenssions.height10 * 5,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimenssions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                          text: UserController.userModel.name)),
                                  SizedBox(
                                    height: Dimenssions.height30,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        size: Dimenssions.height10 * 5,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimenssions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                          text:
                                              UserController.userModel.phone)),
                                  SizedBox(
                                    height: Dimenssions.height30,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        size: Dimenssions.height10 * 5,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimenssions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                          text:
                                              UserController.userModel.email)),
                                  SizedBox(
                                    height: Dimenssions.height30,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        size: Dimenssions.height10 * 5,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimenssions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(
                                          text: "Fill in your address")),
                                  SizedBox(
                                    height: Dimenssions.height30,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        size: Dimenssions.height10 * 5,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimenssions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(text: "messages")),
                                  SizedBox(
                                    height: Dimenssions.height30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          size: Dimenssions.height10 * 5,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize:
                                              Dimenssions.height10 * 5 / 2,
                                        ),
                                        bigText: BigText(text: "Logout")),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : CustomLoeader())
              : Container(
                  child: Center(
                    child: Text("You must login"),
                  ),
                );
        },
      ),
    );
  }
}
