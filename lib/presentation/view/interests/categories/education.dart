import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/presentation/view/interests/categories/widgets/interest_header.dart';
import 'package:spark/presentation/view/interests/categories/widgets/selection_box.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> educationLevels = [
  'Sixth Form',
  'Technical College',
  'I am an Undergrad', // Consider using 'Undergraduate Degree' for consistency
  'Undergraduate Degree',
  'I am a Postgrad',   // Consider using 'Postgraduate Degree' for consistency
  'Postgraduate Degree',
];

     return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InterestHeader(
              icon: Icons.cast_for_education, text: AppStrings.educationQ),
    
          //fields
    
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: educationLevels.length,
              itemBuilder: (context, index){
                return BlocBuilder<InterestsBloc, InterestsState>(
                  builder: (context, state) {
                    if(state is EducationInputState){
                       return InkWell(
                        onTap: () {
                          //debugPrint(workOutOptions[index]);
                          context.read<InterestsBloc>().add(EducationInterestSelectedEvent(educationLevels[index]));
                        },
                        child: SelectionField(titleText:educationLevels[index],groupValueText: state.selectedEdu,));
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
              context.read<InterestsBloc>().add(EducationInterestSubmittedEvent(context));
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