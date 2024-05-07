import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/presentation/view/interests/categories/widgets/interest_header.dart';
import 'package:spark/presentation/view/interests/categories/widgets/selection_box.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class DrinkScreen extends StatelessWidget {
  const DrinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> drinkFrequencyList = [
      'Frequently',
      'Socially',
      'Rarely',
      'Never',
      'Sober',
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InterestHeader(icon: Icons.no_drinks, text: AppStrings.drinkQ),

          //fields
          const SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 450,
            child: ListView.builder(
                itemCount: drinkFrequencyList.length,
                itemBuilder: (context, index) {
                  return BlocBuilder<InterestsBloc, InterestsState>(
                      builder: (context, state) {
                    if (state is DrinkInputState) {
                      return InkWell(
                          onTap: () {
                            debugPrint(drinkFrequencyList[index]);
                            context.read<InterestsBloc>().add(
                                DrinkInterestSelectedEvent(
                                    drinkFrequencyList[index]));
                          },
                          child: SelectionField(
                            titleText: drinkFrequencyList[index],
                            groupValueText: state.selectedDrinkFreq,
                          ));
                    }
                    return const SizedBox();
                  });
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<InterestsBloc>()
              .add(DrinkInterestSubmittedEvent(context));
        },
        backgroundColor: AppColors.blackColor,
        child: const Icon(
          Icons.navigate_next,
          color: AppColors.whiteColor,
        ),
      ),
    
    );
  }
}
