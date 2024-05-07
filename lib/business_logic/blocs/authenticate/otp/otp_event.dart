abstract class OtpEvent{}
class OtpSubmitEvent extends OtpEvent{}
class ResendOtpEventEvent extends OtpEvent{}
class WrongOtpSubmittedEvent extends OtpEvent{}