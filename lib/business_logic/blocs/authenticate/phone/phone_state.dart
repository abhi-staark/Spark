import 'package:intl_phone_field/phone_number.dart';

abstract class PhoneState{
  PhoneNumber? phoneNumber;
  PhoneState({required this.phoneNumber});

}

class PhoneinitialState extends PhoneState{
  PhoneinitialState(): super(phoneNumber:null);

}
class PhoneLodingState extends PhoneState{
  PhoneLodingState(PhoneNumber phoneNumber): super(phoneNumber:phoneNumber);

}

class OtpSuccessFullySentState extends PhoneState{
  OtpSuccessFullySentState(PhoneNumber phoneNumber): super(phoneNumber: phoneNumber);

}

class OtpFailedToSendState extends PhoneState{
  OtpFailedToSendState(PhoneNumber phoneNumber): super(phoneNumber: phoneNumber);
}
