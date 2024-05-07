import 'package:flutter/material.dart';

abstract class OnboardingEvent {}

class NameSubmittedEvent extends OnboardingEvent {
  final String name;
  BuildContext context;

  NameSubmittedEvent(this.name, this.context);
}

class AgeSubmittedEvent extends OnboardingEvent {
  final String age;
  BuildContext context;


  AgeSubmittedEvent(this.age, this.context);
}

class GenderSwitchChangedEvent extends OnboardingEvent{
  final bool switchValue;
  GenderSwitchChangedEvent(this.switchValue);

}

class CheckboxChangedEvent extends OnboardingEvent{
  final int index;
  CheckboxChangedEvent(this.index);

}

class GenderSubmittedEvent extends OnboardingEvent {
  final BuildContext context;
  GenderSubmittedEvent(this.context);

}


class DatingModeChangedEvent extends OnboardingEvent{
  final String mode;
  DatingModeChangedEvent(this.mode);


}

class DatingModeSubmittedEvent extends OnboardingEvent{

}

class AddImageEvent extends OnboardingEvent{
  BuildContext context;
  int index;
  AddImageEvent(this.context, this.index);


}
class RemoveImageEvent extends OnboardingEvent{}

class ImagesSubmittedEvent extends OnboardingEvent{
  BuildContext context;
  ImagesSubmittedEvent(this.context);

}


class SubmitAllDataEvent extends OnboardingEvent{
  BuildContext context;
  SubmitAllDataEvent(this.context);
}
