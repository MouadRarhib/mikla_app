import 'package:flutter/material.dart';
import 'package:mikla_project/utils/dimention.dart';
import 'package:mikla_project/widgets/app_icon.dart';
import 'package:mikla_project/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: Dimenssions.width20,
          top: Dimenssions.width10,
          bottom: Dimenssions.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimenssions.width20,
          ),
          bigText
        ],
      ),
      /* decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 1,
          offset: Offset(0, 2),
          color: Colors.grey.withOpacity(0.2),
        )
      ]),*/
    );
  }
}
