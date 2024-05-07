import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/mail_id/auth_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/mail_id/auth_event.dart';
import 'package:spark/presentation/common/asset_image.dart';
import 'package:spark/presentation/common/primary_button.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/utils/constants/asset_path.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAndroid=Platform.isAndroid;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 0,
              ),
              //spark text
              Column(
                children: [
                  Text(
                    AppStrings.appName.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        letterSpacing: 4,
                        color: AppColors.blackColor,
                        fontSize: 36),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //subtitle

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Text(
                      AppStrings.subtitle,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),

              //app logo
              const AssetImageWidget(
                imagePath: AssetPath.applogo,
                height: 100,
                width: 100,
              ),

              //mobile number sign

              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.phone);
                    },
                    child: const PrimaryButton(
                        buttonHeight: 50,
                        buttonWidth: 325,
                        buttonString: 'Use mobile number',
                        buttonColor: AppColors.blackColor,
                        textColor: AppColors.whiteColor),
                  ),

                  //google sign in
                  const SizedBox(
                    height: 10,
                  ),
                  

                  const SizedBox(
                    height: 10,
                  ),
           
                  InkWell(
                    onTap: () {
                             isAndroid? {
                              debugPrint("Google sign in"),
                              context.read<AuthBloc>().add(GoogleSignInEvent(context))
                             
                             }: {debugPrint("Apple sign in"),
                             context.read<AuthBloc>().add(AppleIdSignInEvent(context))
                             };
                    },
                    child:  PrimaryButton(
                        buttonHeight: 50,
                        buttonWidth: 325,
                        buttonString: isAndroid ?'Sign In With Google':'Sign in with Apple',
                        buttonColor: AppColors.blackColor,
                        textColor: AppColors.whiteColor),
                  )
                  
                ],
              ),
              //terms and conditions
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    AppStrings.disclaimer,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
