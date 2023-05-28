import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mikla_project/controllers/recommended_product_controller.dart';
import 'package:mikla_project/routes/route_helper.dart';
import 'package:mikla_project/utils/dimention.dart';

import '../controllers/popular_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(Duration(seconds: 3), () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              "assets/images/Logo.png",
              width: Dimenssions.splashImg,
            )),
          )
        ],
      ),
    );
  }
}
