
import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class PlansContainerWidget extends StatelessWidget {
  const PlansContainerWidget({
    super.key,
    required this.planDuration,
    required this.planPrice,
    required this.isSelected,
  });
  final String planDuration;
  final String planPrice;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 200,
        width: 100,
        decoration: BoxDecoration(
            color: isSelected
                ? AppColors.whiteColor.withOpacity(0.5)
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 0.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //title
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  planDuration.split(' ').first,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: AppColors.blackColor),
                  maxLines: 2,
                  softWrap: true,
                ),
                Text(
                  planDuration.split(' ').last,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.blackColor,
                      ),
                  maxLines: 2,
                  softWrap: true,
                ),
              ],
            ),
            //price
            Text(
              "$planPrice INR",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blackColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
