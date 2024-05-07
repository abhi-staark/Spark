import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/presentation/view/interests/categories/widgets/interest_header.dart';
import 'package:spark/presentation/view/interests/categories/widgets/selection_box.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class PoliticalScreen extends StatelessWidget {
  const PoliticalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> politicalLeanings = [
  'Apolitical',
  'Independent', // Replaces "omdeae" (unclear term)
  'Left',
  'Right',
  'Communist',
  'Socialist',
];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InterestHeader(
              icon: Icons.how_to_vote_outlined, text: AppStrings.politicalQ),
    
          //fields
          const SizedBox(height: 20,),
    
          SizedBox(
            height: 450,
            child: ListView.builder(
              itemCount: politicalLeanings.length,
              itemBuilder: (context, index){
                return BlocBuilder<InterestsBloc, InterestsState>(
                  builder: (context, state) {
                    if(state is PoliticalInputState){
                       return InkWell(
                        onTap: () {
                          debugPrint(politicalLeanings[index]);
                          context.read<InterestsBloc>().add(PoliticalInterestSelectedEvent(politicalLeanings[index]));
                        },
                        child: SelectionField(titleText:politicalLeanings[index],groupValueText: state.politicalInterest,));
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
              context.read<InterestsBloc>().add(PoliticalInterestSubmittedEvent(context));
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