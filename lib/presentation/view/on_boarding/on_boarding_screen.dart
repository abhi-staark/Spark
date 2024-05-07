import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_state.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/presentation/view/on_boarding/categories/age.dart';
import 'package:spark/presentation/view/on_boarding/categories/gender.dart';
import 'package:spark/presentation/view/on_boarding/categories/images.dart';
import 'package:spark/presentation/view/on_boarding/categories/mode.dart';
import 'package:spark/presentation/view/on_boarding/categories/name.dart';
import 'package:spark/utils/constants/colors.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final OnboardingViewModel viewModel = OnboardingViewModel();
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if(state is OnBoardingSuccessState){
          Navigator.pushNamed(context, RouteNames.interests);
        } //handle other if you want
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: state.progress,
                  backgroundColor: Colors.grey,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.blackColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _buildScreen(state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

Widget _buildScreen(OnboardingState state) {
  switch (state.runtimeType) {
    case NameInputState:
      return const NameScreen();
    case AgeInputState:
      return const AgeScreen();
    case GenderInputState:
      return const GenderScreen();
    case DatingModeInputState:
      return const DatingModeScreen();
    case ImagesInputState:
    case OnBoardingSuccessState://sincel it is on last screen stay there only
      return const PickImagesScreen();
    case OnboardingLoadingState:
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.blackColor,
          ),
        ),
      );
    default:
      return const Center(
        child: Text('Something went wrong'),
      );
  }
}

}
