import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key, required this.height, required this.icon,
  });
  final double height;
final IconData icon;


  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Container(
      color: AppColors.whiteColor,
      height: height,
      width: height,
      child: Center(
          child: Icon(
       icon,
       color: AppColors.blackColor,
        size: height/2,
      )),
    ));
  }
}