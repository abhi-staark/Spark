import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';
//used in profile screen, for edit profile 
class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 120,
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          'Edit Profile',
          style: textTheme.bodySmall!.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ),
    );
  }
}
