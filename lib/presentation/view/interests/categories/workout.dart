import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/presentation/view/interests/categories/widgets/interest_header.dart';
import 'package:spark/presentation/view/interests/categories/widgets/selection_box.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> workOutOptions=['Active', 'Sometimes', 'Never'];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InterestHeader(
              icon: Icons.sports_mma_outlined, text: AppStrings.workOutQ),
    
          //fields
          const SizedBox(height: 20,),
    
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: workOutOptions.length,
              itemBuilder: (context, index){
                return BlocBuilder<InterestsBloc, InterestsState>(
                  builder: (context, state) {
                    if(state is WorkoutInputState){
                       return InkWell(
                        onTap: () {
                          debugPrint(workOutOptions[index]);
                          context.read<InterestsBloc>().add(WorkoutInterestSelectedEvent(workOutOptions[index]));
                        },
                        child: SelectionField(titleText:workOutOptions[index],groupValueText: state.selectedInterest,));
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
              context.read<InterestsBloc>().add(WorkoutInterestSubmittedEvent(context));
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

