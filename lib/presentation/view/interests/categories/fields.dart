import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/business_logic/models/interests_model.dart';
import 'package:spark/presentation/view/interests/categories/widgets/interest_container.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class FieldsScreen extends StatelessWidget {
  const FieldsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          const SizedBox(height: 30),
          //whats your name texts
          Text(
            AppStrings.fieldTitle,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                letterSpacing: 2, color: AppColors.blackColor, fontSize: 30),
          ),
          Text(
            AppStrings.subtitleSubtitle,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  letterSpacing: 1,
                  color: AppColors.blackColor,
                ),
          ),
          const SizedBox(height: 30),
          //list
          Expanded(child: BlocBuilder<InterestsBloc, InterestsState>(
              builder: (context, state) {
            if (state is FieldsInputState) {
              return ListView.builder(
                itemCount: state.interestCategoriesList.length,
                itemBuilder: (context, index) {
                  InterestCategory category = state.interestCategoriesList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Text(category.title,
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        SizedBox(
                          height: 120,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2, // Adjust this ratio as needed
                            ),
                            itemCount: category.interests.length,
                            itemBuilder: (context, interestIndex) {
                              String interest = category.interests[interestIndex];
                              bool hasInterest=state.userIntersts.contains(interest);
                              return InkWell(
                                onTap: (){
                                  context.read<InterestsBloc>().add(SelectInterestEvent(interest, state.interestCategoriesList));
                                },
                                child: InterestContainer(interestText: interest,hasInterest: hasInterest,));
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          })),
    
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
                context.read<InterestsBloc>().add(FieldsInterestsSubmittedEvent(context));
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
