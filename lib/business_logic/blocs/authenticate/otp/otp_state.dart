abstract class OtpState{}

class OtpInitialState extends OtpState{}
class OtpLoadingState extends OtpState{}
class OtpVerifySuccessState extends OtpState{}
class OtpVerifyFailureState extends OtpState{}