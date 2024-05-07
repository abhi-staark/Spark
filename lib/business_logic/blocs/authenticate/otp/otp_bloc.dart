import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/otp/otp_event.dart';
import 'package:spark/business_logic/blocs/authenticate/otp/otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState>{
  OtpBloc():super(OtpInitialState()){
    on<OtpSubmitEvent>((event, emit) => otpSubmitEvent(event, emit));
    on<ResendOtpEventEvent>((event, emit) => resendOtpEventEvent(event, emit));
    on<WrongOtpSubmittedEvent>((event, emit) => wrongOtpSubmittedEvent(event, emit));
  }
  
  otpSubmitEvent(OtpSubmitEvent event, Emitter<OtpState> emit)async{
    emit(OtpLoadingState());
    //make api call for verifying otp message
    await Future.delayed(const Duration(seconds: 3));

    //emit(OtpVerifySuccessState()); or 
    //emit(OtpVerifyFailureState()); basesd on the output from api
    emit(OtpVerifySuccessState());


  }
  
  resendOtpEventEvent(ResendOtpEventEvent event, Emitter<OtpState> emit) {
    print("RESEND Otp");
  }
  
  wrongOtpSubmittedEvent(WrongOtpSubmittedEvent event, Emitter<OtpState> emit) {
     print("Wrong Otp submitted");
  }

}