import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_event.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_state.dart';
import 'package:spark/business_logic/models/on_boarding_mode_item.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class DatingModeScreen extends StatelessWidget {
  const DatingModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ModeItem> items = [
    ModeItem(title: "Date", subtitle: "Join the empowered community and ignite your spark!"),
    ModeItem(title: "BFF", subtitle: "Fresh faces, fresh perspectives – make new friends and keep life exciting."),
    ModeItem(title: "Bizz", subtitle: "The modern career journey is all about connecting with the right people."),
  ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              AppStrings.onBoardingMode1,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    letterSpacing: 2,
                    color: AppColors.blackColor,
                    fontSize: 30,
                  ),
            ),
            Text(
              AppStrings.onBoardingMode2,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    letterSpacing: 1,
                    color: AppColors.blackColor,
                    fontSize: 30,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppStrings.onBoardingMode3,
              maxLines: 4,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.blackColor.withOpacity(0.8), letterSpacing: 0.11),
            ),

            //checkboxlist tiles
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: BlocBuilder<OnboardingBloc, OnboardingState>(
                          builder: (context, state) {
                        if (state is DatingModeInputState) {
                          return Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.greyColor)
                            ),
                            child: Center(
                              child: ListTile(
                                enabled:true,
                                onTap: () {
                                  context.read<OnboardingBloc>().add(DatingModeChangedEvent( items[index].title));
                                },
                                title: Text(
                                 items[index].title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  items[index].subtitle,
                                  maxLines: 3,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: Radio(
                                  activeColor: AppColors.blackColor,
                                    value: items[index].title.toString(),
                                    groupValue: state.datingMode,
                                    onChanged: (newValue) {
                                      context.read<OnboardingBloc>().add(DatingModeChangedEvent( items[index].title));
                                    },
                                    
                                    ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    );
                  }),
            )
          ],
        ),
        //floating action button
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
                        // Dispatch event to Bloc
                        context.read<OnboardingBloc>().add(DatingModeSubmittedEvent());
                      },
                child: state is OnboardingLoadingState
                    ? const CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      )
                    : const Icon(
                        Icons.navigate_next,
                        color: AppColors.whiteColor,
                      ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
