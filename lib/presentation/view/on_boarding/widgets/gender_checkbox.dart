
import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class CustomCheckBoxTIle extends StatelessWidget {
  const CustomCheckBoxTIle({
    super.key, required this.text,required this.value
  });
  final String text;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.blackColor.withOpacity(0.5)),
      ),
      child: CheckboxListTile(
        value: value, 
        enabled:false,
        onChanged: (newValue) {
        },
        checkboxShape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(3)),
        activeColor: AppColors.blackColor,
        checkColor:AppColors.whiteColor,
        fillColor: value? const MaterialStatePropertyAll(AppColors.blackColor): null,
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    
    );
  }
}
