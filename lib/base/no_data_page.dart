import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String imgPath;
  const NoDataPage({super.key, this.imgPath = "assets/images/empty.png"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        )
      ],
    );
  }
}
