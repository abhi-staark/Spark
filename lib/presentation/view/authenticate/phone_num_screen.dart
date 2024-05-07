import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/phone/phone_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/phone/phone_event.dart';
import 'package:spark/business_logic/blocs/authenticate/phone/phone_state.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';
import 'package:spark/presentation/view/authenticate/widgets/phone_picker.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // PhoneViewModel phoneViewModel = PhoneViewModel();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //whats your number text
            Text(
              AppStrings.whatsYour,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: 2, color: AppColors.blackColor, fontSize: 36),
            ),
            Text(
              AppStrings.number,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  letterSpacing: 1, color: AppColors.blackColor, fontSize: 36),
            ),

            const SizedBox(
              height: 30,
            ),

            //we protect your number disclaimer
            Text(
              AppStrings.phoneSecurityDisclaimer,
              maxLines: 4,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),

            const SizedBox(
              height: 20,
            ),

            //country code and phone number auto enabld
            const CustomPhoneNumberPicker()
          ]),
        ),
        floatingActionButton: BlocConsumer<PhoneBloc, PhoneState>(
          listener: (context, state) {
            if (state is OtpSuccessFullySentState) {
              // Navigate to the OTP screen when OTP is successfully sent
              Navigator.pushNamed(context, RouteNames.otp, arguments: state.phoneNumber!.completeNumber.toString());
            }
          },
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                if (state is PhoneLodingState) {
                  return;
                } else {
                  // Handle button press when state is not loading or OTP successfully sent
                  debugPrint("Submitted Number : ${state.phoneNumber}");
                  if (state.phoneNumber != null) {
                    // Submit phone number using phoneViewModel
                    context.read<PhoneBloc>().add(PhoneNumberSubmittedEvent(context: context,completeNumber:state.phoneNumber!.completeNumber.toString(),number:state.phoneNumber!.number.toString(),  ));
                    // phoneViewModel.submitPhoneNumber(
                    //   context,
                    //   state.phoneNumber!.completeNumber.toString(),
                    //   state.phoneNumber!.number.toString(),
                    // );
                  }
                }
              },
              backgroundColor: state is PhoneLodingState
                  ? AppColors.greyColor
                  : AppColors.blackColor,
              child:  state is PhoneLodingState
              ? const CircularProgressIndicator(color: AppColors.whiteColor,strokeWidth: 3,)
              : const Icon(
                Icons.navigate_next,
                color: AppColors.whiteColor,
              ),
            );
          },
        ),
      
      ),
    );
  }
}

