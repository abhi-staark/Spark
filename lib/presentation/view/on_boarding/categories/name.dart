import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_event.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_state.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            //whats your name texts
            Text(
              AppStrings.onBoardingFirstName,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: 2, color: AppColors.blackColor, fontSize: 30),
            ),
            Text(
              AppStrings.onBoardingName,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: 1, color: AppColors.blackColor, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            //cant chnage the name text
            Text(
              AppStrings.nameDisclaimer,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    letterSpacing: 0.5,
                    color: AppColors.blackColor,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            //text field for name input
    
               SizedBox(
                height: 50,
                child: TextField(
                  controller: nameController,
                  enabled: true,
                  onSubmitted: (value) {
                    print(value);
                    context.read<OnboardingBloc>().add(NameSubmittedEvent(nameController.text, context));

                    //call submit event
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              )
          ],
        ),
        BlocBuilder<OnboardingBloc, OnboardingState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: AppColors.blackColor,
                  onPressed: state is OnboardingLoadingState
                      ? () {}
                      : () {
                          context
                              .read<OnboardingBloc>()
                              .add(NameSubmittedEvent(nameController.text, context));
                        },
                  child: state is OnboardingLoadingState
                      ? const CircularProgressIndicator(
                          color: AppColors.whiteColor,
                        )
                      : const Icon(
                          Icons.navigate_next,
                          color: AppColors.whiteColor,
                        ),
                )),
          );
        })
      ],
    );
  }
}
