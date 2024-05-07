import 'package:image_picker/image_picker.dart';

abstract class OnboardingState {
  double progress;
  OnboardingState({required this.progress});
}

class OnboardingLoadingState extends OnboardingState {
  OnboardingLoadingState(double progress) : super(progress: progress);
}

class OnboardingErrorState extends OnboardingState {
  final String errorMsg;
  OnboardingErrorState(this.errorMsg, double progress)
      : super(progress: progress);
}
class OnBoardingSuccessState extends OnboardingState{
  OnBoardingSuccessState():super(progress: 1);

}

class NameInputState extends OnboardingState {
  final String name;
  NameInputState(double progress, this.name) : super(progress: progress);
}

class AgeInputState extends OnboardingState {
  AgeInputState(double progress) : super(progress: progress);
}

class GenderInputState extends OnboardingState {
  final bool switchValue;
  final List<bool> checkboxValues;

  GenderInputState(double progress, this.switchValue, this.checkboxValues)
      : super(progress: progress);
}

class DatingModeInputState extends OnboardingState {
  final String datingMode;

  DatingModeInputState(double progress, this.datingMode)
      : super(progress: progress);
}

class ImagesInputState extends OnboardingState {
  List<XFile?> imageFiles;

  ImagesInputState(double progress, this.imageFiles) : super(progress: progress);
}
