
import 'package:flutter/material.dart';
import 'package:spark/business_logic/models/guideline.dart';
import 'package:spark/utils/constants/colors.dart';

class GuidelineItem extends StatelessWidget {
  final Guideline guideline;

  const GuidelineItem({Key? key, required this.guideline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            guideline.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          Text(
            guideline.description,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.greyColor, height: 1.4)
          ),
        ],
      ),
    );
  }
}