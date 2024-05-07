import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class InterestContainer extends StatelessWidget {
  const InterestContainer({
    super.key,
    required this.interestText,
    required this.hasInterest
  });

  final String interestText;
  final bool hasInterest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(               
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: hasInterest?AppColors.primaryColor: null,
            border: Border.all(color: Colors.grey)),
        child: Center(
          child: Text(
            interestText,
            maxLines: 2,textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
