import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/base/custom_loader.dart';
import 'package:mikla_project/base/show_costum_snack_bar.dart';
import 'package:mikla_project/controllers/auth_controller.dart';
import 'package:mikla_project/pages/auth/sign_up_page.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_text_fileld.dart';
import 'package:mikla_project/widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email Address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getSplashPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimenssions.screenHeight * 0.05,
                        ),
                        //Applogo
                        Container(
                          height: Dimenssions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/images/Logo.png"),
                            ),
                          ),
                        ),
                        // Welcome
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: Dimenssions.width20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                  fontSize: Dimenssions.font20 * 3 +
                                      Dimenssions.font20 / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Sign in to your account",
                                style: TextStyle(
                                  fontSize: Dimenssions.font20,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimenssions.height20,
                        ),
                        AppTextField(
                            textController: emailController,
                            hintText: "email",
                            icon: Icons.email),
                        SizedBox(
                          height: Dimenssions.height20,
                        ),
                        AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          isObscure: true,
                        ),

                        SizedBox(
                          height: Dimenssions.height20,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                                text: TextSpan(
                                    text: "Sign into your account",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: Dimenssions.font20))),
                            SizedBox(
                              width: Dimenssions.width20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimenssions.screenHeight * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            width: Dimenssions.screenWidth / 2.5,
                            height: Dimenssions.screenHeight / 13,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimenssions.radius30),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                size: Dimenssions.font20 +
                                    Dimenssions.font20 / 2.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimenssions.screenHeight * 0.05,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Don\'t have an account? ",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimenssions.font26 - 10),
                                children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage(),
                                      transition: Transition.fade),
                                text: "Create",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlackcolor,
                                    fontSize: Dimenssions.font26 - 10),
                              )
                            ])),
                      ],
                    ),
                  )
                : CustomLoeader();
          },
        ));
  }
}
