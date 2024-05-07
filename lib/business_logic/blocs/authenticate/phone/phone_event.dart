
abstract class PhoneEvents{}

class PhoneNumberSubmittedEvent extends PhoneEvents{
  var context; 
  String completeNumber;
   String number;
   PhoneNumberSubmittedEvent({required this.context, required this.completeNumber, required this.number});
   

}