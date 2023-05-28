import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/controllers/auth_controller.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';

class CustomLoeader extends StatelessWidget {
  const CustomLoeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimenssions.height20 * 5,
        width: Dimenssions.height20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimenssions.height20 * 5 / 2),
          color: AppColors.mainColor,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
