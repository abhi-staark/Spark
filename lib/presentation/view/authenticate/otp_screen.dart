import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spark/business_logic/blocs/authenticate/otp/otp_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/otp/otp_event.dart';
import 'package:spark/business_logic/blocs/authenticate/otp/otp_state.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    //OtpViewModel otpViewModel = OtpViewModel();
    final TextEditingController otpController=TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                const SizedBox(
                  height: 30,
                ),
                 //verifyNumber text
                Text(
                  AppStrings.verifyNumber,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      letterSpacing: 2,
                      color: AppColors.blackColor,
                      fontSize: 36),
                ),
                Text(
                  AppStrings.number,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      letterSpacing: 1,
                      color: AppColors.blackColor,
                      fontSize: 36),
                ),
                const SizedBox(
                  height: 20,
                ),
                //code sent to number message
                Row(
                  children: [
                    Text(
                      AppStrings.codeSent,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          letterSpacing: 1,
                          color: AppColors.blackColor,
                          fontSize: 12),
                    ),
                    Text(
                      phoneNumber,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          letterSpacing: 1,
                          color: AppColors.greyColor,
                          fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),
                //otp field
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedColor: Colors.white,
                    inactiveColor: Colors.white,
                    selectedFillColor: Colors.grey.shade300,
                    inactiveFillColor: Colors.grey.shade300,
                  ),
                  animationDuration: const Duration(milliseconds: 300),

                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  controller: otpController,
                  onCompleted: (value) {
                    print("Completed");
                    context.read<OtpBloc>().add(OtpSubmitEvent());
                    
                    //otpViewModel.verifyOtp(context, value);
                  },
                  onChanged: (value) {
                    print(value);

                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                //text

                Row(
                  children: [
                    Text(
                      AppStrings.didntGetCode,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            letterSpacing: 1,
                            color: AppColors.blackColor,
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        //resend code function
                        //otpViewModel.resendOtp(context, phoneNumber);
                        context.read<OtpBloc>().add(ResendOtpEventEvent());
                      },
                      child: Text(
                        AppStrings.resendAagain,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              letterSpacing: 1,
                              color: AppColors.primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
        floatingActionButton: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state){
            if(state is OtpVerifySuccessState){
              Navigator.pushNamed(context, RouteNames.onBoarding);
            }else if(state is OtpVerifyFailureState){
              //otpViewModel.wrongOtpMessage(context, 'error message');
              context.read<OtpBloc>().add(WrongOtpSubmittedEvent());
            }
          },
          builder: (context, state){
            if(state is OtpLoadingState){
              return FloatingActionButton(
                backgroundColor: AppColors.blackColor,
                onPressed: (){
                },
                child: const CircularProgressIndicator(color: AppColors.whiteColor,),
                );
            }else{
              return FloatingActionButton(
          onPressed: () {
            // otpViewModel.verifyOtp(context, otpController.text);
            context.read<OtpBloc>().add(OtpSubmitEvent());
          },
          backgroundColor: AppColors.blackColor,
          child: const Icon(
            Icons.navigate_next,
            color: AppColors.whiteColor,
          ),
        );
            }

          } )
        
        
      ),
    );
  }
}
