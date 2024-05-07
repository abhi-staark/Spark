import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/phone/phone_event.dart';
import 'package:spark/business_logic/blocs/authenticate/phone/phone_state.dart';
import 'package:spark/services/app_services.dart';
import 'package:spark/utils/constants/asset_path.dart';

import '../../../../utils/alerts/snack_bar.dart';
class PhoneBloc extends Bloc<PhoneEvents, PhoneState>{
  PhoneBloc(): super(PhoneinitialState()){
    //on evnents
    on<PhoneNumberSubmittedEvent>((event, emit) => phoneNumberSubmittedEvent(event, emit));

  }
  
  Future<void> phoneNumberSubmittedEvent(PhoneNumberSubmittedEvent event, Emitter<PhoneState> emit) async{
    emit(PhoneLodingState(state.phoneNumber!));
    await Future.delayed(const Duration(seconds: 5));

    //make api call

    AppServices appServices= AppServices();
    if(appServices.isValidNumber(event.completeNumber, event.number)){
       emit(OtpSuccessFullySentState(state.phoneNumber!)); 
    }else{
      //Utils show error
      Utils.showSnackBar(event.context, 'Invalid Phone Number, Please try again', AssetPath.failureIcon);
      emit(PhoneinitialState()); 
    }
    //try catch

    //update otp OtpSuccessFullySentEvent or failure event
   

    //clear phone number from states values

  
  }
}