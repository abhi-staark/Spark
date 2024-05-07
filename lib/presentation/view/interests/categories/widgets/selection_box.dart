import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class SelectionField extends StatelessWidget {
  const SelectionField({
    super.key,
    required this.titleText,
    required this.groupValueText
  });
  final String titleText;
  final String groupValueText;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.greyColor)),
        child: Center(
          child: ListTile(
            enabled: false,
            title: Text(
              titleText,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: Radio(
              activeColor: AppColors.blackColor,
              value: titleText,
              groupValue: groupValueText,
              onChanged: (newValue) {
                //  context.read<InterestsBloc>().add(WorkoutInterestSelectedEvent(titleText));
              },
            ),
          ),
        ),
      ),
    );
  }
}
