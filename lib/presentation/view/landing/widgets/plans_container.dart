import 'package:flutter/material.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/presentation/common/primary_button.dart';
import 'package:spark/utils/constants/colors.dart';

class PlansContainer extends StatelessWidget {
  const PlansContainer({
    super.key,
    required this.textTheme, required this.title, required this.description,
  });


  final TextTheme textTheme;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10.0),
      child: Container(
        height: 180,
        width: 330,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius:
                BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Text(
               title,
                style: textTheme.titleMedium,
              ),
              Text(
                description,
                maxLines: 3,
                softWrap: true,
                style: textTheme.bodySmall,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.plans,arguments: title);
                  },
                  child: PrimaryButton(
                      buttonHeight: 50,
                      buttonWidth: 200,
                      buttonString:'Upgrade to $title',
                      buttonColor: AppColors.whiteColor,
                      textColor:AppColors.blackColor))
            ],
          ),
        ),
      ),
    );
  }
}

