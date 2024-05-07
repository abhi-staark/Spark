import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_event.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_state.dart';
import 'package:spark/presentation/view/on_boarding/widgets/gender_checkbox.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> gendersList=['Men', 'Women', 'Non-Binary'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              AppStrings.onBoardinggender1,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    letterSpacing: 2,
                    color: AppColors.blackColor,
                    fontSize: 30,
                  ),
            ),
            Text(
              AppStrings.onBoardinggender2,
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
              AppStrings.onBoardinggender3,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    letterSpacing: 0.5,
                    color: AppColors.blackColor,
                  ),
            ),
            const SizedBox(height: 20),
            //single switch box
            Row(
              children: [
                BlocBuilder<OnboardingBloc, OnboardingState>(
                    builder: (context, state) {
                   if(state is GenderInputState){
                    return Switch.adaptive(
                    activeColor: AppColors.blackColor,
                    value: state.switchValue, // Provide value based on state
                    onChanged: (newValue) {
                      // Dispatch event to Bloc
                      context.read<OnboardingBloc>().add(GenderSwitchChangedEvent(newValue));
                    },
                  );

                  }return const SizedBox();
                }),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                              AppStrings.onBoardinggender4,
                              maxLines: 2,
                              softWrap: true,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                wordSpacing: 1,
                                letterSpacing: 0.11,
                      color: AppColors.blackColor,
                    ),
                            ),
                ),

              ],
            ),
            //checkboxlist tiles
            const SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: gendersList.length,
                itemBuilder:  (context, index){
                  return   Padding(
                    padding:  const EdgeInsets.only(bottom:20.0),
                    child:  BlocBuilder<OnboardingBloc, OnboardingState>(
                      builder: (context, state) {
                        if(state is GenderInputState){
                          return InkWell(
                            onTap: () {
                              context.read<OnboardingBloc>().add(CheckboxChangedEvent(index));  
                            },
                         
                            child:CustomCheckBoxTIle(text:gendersList[index],value: state.checkboxValues[index],) );
                        }else{
                          return const SizedBox();
                        }
                      }
                    ),
                  );
                }
               ),
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
                        context.read<OnboardingBloc>().add(GenderSubmittedEvent(context));
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
