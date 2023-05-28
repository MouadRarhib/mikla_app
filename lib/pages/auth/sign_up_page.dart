import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/base/custom_loader.dart';
import 'package:mikla_project/base/show_costum_snack_bar.dart';
import 'package:mikla_project/controllers/auth_controller.dart';
import 'package:mikla_project/models/signup_body_model.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_text_fileld.dart';
import 'package:mikla_project/widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var singUpImages = [
      "twitter.png",
      "facebook.png",
      "instagram.png",
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
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
        //showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        print(signUpBody.toString());
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimenssions.screenHeight * 0.05,
                        ),
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
                          isObscure: true, // for dont showing the mdps
                        ),
                        SizedBox(
                          height: Dimenssions.height20,
                        ),
                        AppTextField(
                            textController: nameController,
                            hintText: "Name",
                            icon: Icons.person),
                        SizedBox(
                          height: Dimenssions.height20,
                        ),
                        AppTextField(
                            textController: phoneController,
                            hintText: "Phone",
                            icon: Icons.phone),
                        SizedBox(
                          height: Dimenssions.height20 + Dimenssions.font20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _registration(_authController);
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
                                text: "Sign up",
                                size: Dimenssions.font20 +
                                    Dimenssions.font20 / 2.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimenssions.height10,
                        ),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                                text: "Have an account already?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimenssions.font20))),
                        SizedBox(
                          height: Dimenssions.screenHeight * 0.05,
                        ),
                        RichText(
                            text: TextSpan(
                                text:
                                    "Sign up using one of the following methods ",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimenssions.font26 - 10))),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(2.3),
                                    child: CircleAvatar(
                                      radius: Dimenssions.radius30 - 5,
                                      backgroundImage: AssetImage(
                                          "assets/images/" +
                                              singUpImages[index]),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  )
                : const CustomLoeader();
          },
        ));
  }
}
