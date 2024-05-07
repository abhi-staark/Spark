import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/presentation/view/interests/categories/widgets/interest_header.dart';
import 'package:spark/presentation/view/interests/categories/widgets/selection_box.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class StarSignScreen extends StatelessWidget {
  const StarSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final List<String> zodiacSigns = [
  'Aries',
  'Taurus',
  'Gemini',
  'Cancer',
  'Leo',
  'Virgo',
  'Libra',
  'Scorpio',
  'Sagittarius',
  'Capricorn',
  'Aquarius',
  'Pisces',
];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             const InterestHeader(
              icon: Icons.stars_sharp, text: AppStrings.starSignQ),
              SizedBox(
                height: 550,
                child: ListView.builder(
                  itemCount: zodiacSigns.length,
                  itemBuilder: (context, index){
                    return BlocBuilder<InterestsBloc, InterestsState>(
                      builder: (context, state) {
                        if(state is StarSignInputState){
                          return InkWell(
                          onTap: () {
                            debugPrint(zodiacSigns[index]);
                            context.read<InterestsBloc>().add(StarSignInterestSelectedEvent(zodiacSigns[index]));
                            
                          },
                          child: SelectionField(titleText: zodiacSigns[index], groupValueText: state.selectedStarSign),
              
                        );
                        }
                        return const SizedBox();
                      }
                    );
              
                }),
              )
    

        ],
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<InterestsBloc>().add(StarSignInterestSubmittedEvent(context));
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