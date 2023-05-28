import 'package:flutter/material.dart';
import 'package:mikla_project/utils/colors.dart';
import 'package:mikla_project/utils/dimention.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure; // method for not showing mdps and we do it...
  // in the variable because it work for all of the fields
  AppTextField(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.icon,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimenssions.height20, right: Dimenssions.height20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimenssions.radius30),
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(1, 1),
              color: Colors.grey.withOpacity(0.2)),
        ],
      ),
      child: TextField(
        obscureText: isObscure ? true : false,
        controller: textController,
        decoration: InputDecoration(
            //hint text ,
            hintText: hintText,

            // //prefixIcon
            prefixIcon: Icon(
              icon,
              color: AppColors.yellowColor,
            ),
            //// focuseBorder
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimenssions.radius15),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),

            /// //enableBorder
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimenssions.radius15),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )),

            // border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenssions.radius15),
            )),
      ),
    );
  }
}
