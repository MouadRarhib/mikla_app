import 'package:flutter/material.dart';
import 'package:mikla_project/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimention.dart';
import 'big_text.dart';
import 'icon_and_textwidgets.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BigText(
        text: text,
        size: Dimenssions.font26,
      ),
      SizedBox(
        height: Dimenssions.height10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            //List generate --------------> learn about
            children: List.generate(
                5,
                (index) => Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                      size: Dimenssions.height15,
                    )),
          ),
          SmallText(
            text: '4.5',
            color: AppColors.mainBlackcolor,
          ),
          SmallText(
            text: "1287",
            color: AppColors.mainBlackcolor,
          ),
          SmallText(
            text: "comments",
            color: AppColors.mainBlackcolor,
          )
        ],
      ),
      SizedBox(
        height: Dimenssions.height20 / 1.2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    ]);
  }
}
