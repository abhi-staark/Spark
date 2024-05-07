import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/presentation/common/primary_button.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //title
                  Text(
                   AppStrings.diclaimerTitle,
                    style: textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                        fontSize: 30,
                        height: 1.4,
                        letterSpacing: 1),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    softWrap: true,
                  ),
                  const SizedBox(height: 40),
                  //body
                  buildText(AppStrings.diclaimerText1, textTheme),
                  const SizedBox(height: 20),
                   buildText(AppStrings.diclaimerText2, textTheme),
                  const SizedBox(height: 20),
                  //guidelines
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:AppStrings.diclaimerText4,
                          style: textTheme.bodyLarge!.copyWith(
                              color: AppColors.greyColor,
                              height: 1.4,
                              fontSize: 20.3),
                        ),
                        TextSpan(
                           text:AppStrings.diclaimerText5,
                          style: textTheme.bodyLarge!.copyWith(
                            color: AppColors.greyColor,
                            height: 1.4,
                            fontSize: 20.3,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RouteNames.guidelines);
                            },
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildText(AppStrings.diclaimerText3, textTheme)
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              //i agree button
              InkWell(
                  onTap: () {
                    //make api call event and navigate to home screen
                    Navigator.pushNamed(context, RouteNames.landing);
                  },
                  child: const PrimaryButton(
                      buttonHeight: 45,
                      buttonWidth: 100,
                      buttonString: 'I Agree',
                      buttonColor: AppColors.blackColor,
                      textColor: AppColors.whiteColor))
            ]),
      ),
    );
  }

 
}

//component
 Widget buildText(String text, TextTheme textTheme) {
    double infoFontSIze = 18.0;
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 7,
      style: textTheme.bodyLarge!.copyWith(
          color: AppColors.greyColor, height: 1.4, fontSize: infoFontSIze),
    );
  }