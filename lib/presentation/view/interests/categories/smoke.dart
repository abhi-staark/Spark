import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/presentation/view/interests/categories/widgets/interest_header.dart';
import 'package:spark/presentation/view/interests/categories/widgets/selection_box.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class SmokeScreen extends StatelessWidget {
  const SmokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> smokeFreqList=['Socially', 'Regularly', 'Never'];
      return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InterestHeader(
              icon: Icons.smoking_rooms_outlined, text: AppStrings.smokeQ),
    
    const SizedBox(height: 20,),
          //fields
    
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: smokeFreqList.length,
              itemBuilder: (context, index){
                return BlocBuilder<InterestsBloc, InterestsState>(
                  builder: (context, state) {
                    if(state is SmokeInputState){
                       return InkWell(
                        onTap: () {
                          debugPrint(smokeFreqList[index]);
                          context.read<InterestsBloc>().add(SmokeInterestSelectedEvent(smokeFreqList[index]));
                        },
                        child: SelectionField(titleText:smokeFreqList[index],groupValueText: state.smokeFreq,));
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
              context.read<InterestsBloc>().add(SmokeInterestSubmittedEvent(context));
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