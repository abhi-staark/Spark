
import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class InterestHeader extends StatelessWidget {
  const InterestHeader({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        //icon
        Icon(
          icon,
          size: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        //work out
        Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                letterSpacing: 1,
                
                color: AppColors.blackColor,
                fontSize: 30,
              ),
        ),
      ],
    );
  }
}
