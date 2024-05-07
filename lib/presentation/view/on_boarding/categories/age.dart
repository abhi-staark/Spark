import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_event.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_state.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class AgeScreen extends StatelessWidget {

   const AgeScreen({super.key});
  @override
  Widget build(BuildContext context) {
   
    final dateController = TextEditingController();
    final monthController = TextEditingController();
    final yearController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
             //whats your name texts
            Text(
              AppStrings.onBoardingbirthday1,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: 2, color: AppColors.blackColor, fontSize: 30),
            ),
            Text(
              AppStrings.onBoardingbirthday2,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: 1, color: AppColors.blackColor, fontSize: 30),
            ),
           const SizedBox(
                  height: 20,
                ),
                //cant chnage the name text
                Text(
                  AppStrings.onBoardingbirthday3,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        letterSpacing: 0.5,
                        color: AppColors.blackColor,
                      ),
                ),
            const SizedBox(height: 20),
            _buildBirthdayInput(context, dateController, monthController, yearController),
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
                        
                        String age=dateController.text.trim()+monthController.text+yearController.text.trim();
                        
                        context.read<OnboardingBloc>().add(AgeSubmittedEvent(age, context));
                          // context
                          //     .read<OnboardingBloc>()
                          //     .add(NameSubmittedEvent(nameController.text));
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

  Widget _buildBirthdayInput(BuildContext context, TextEditingController dateController,
    TextEditingController monthController ,
    TextEditingController yearController ) {

    final dateFocusNode = FocusNode();
    final monthFocusNode = FocusNode();
    final yearFocusNode = FocusNode();

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(context, 'Day', dateController,
                TextInputType.number, dateFocusNode, monthFocusNode, 60, 'DD', 2),
            const SizedBox(width: 10),
            _buildTextField(context, 'Month', monthController,
                TextInputType.number, monthFocusNode, yearFocusNode, 60,'MM', 2),
            const SizedBox(width: 10),
            _buildTextField(context, 'Year', yearController,
                TextInputType.number, yearFocusNode, null, 100, 'YYYY', 4),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
    FocusNode focusNode,
    FocusNode? nextFocusNode,
    double width,
    String hintText,
    int charLimit,

  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          width: width,
          height: 50,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: [LengthLimitingTextInputFormatter(charLimit)],
            focusNode: focusNode,
            onSubmitted: (_) {
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }if(nextFocusNode==null){
                //context.read<OnboardingBloc>().add(AgeSubmittedEvent(age))
                 //fabKey.currentState?.onPressed!();

              }

            },
            onChanged: (value) {
              if(value.length==charLimit){
                if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
              }
            },
            
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: hintText,
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
