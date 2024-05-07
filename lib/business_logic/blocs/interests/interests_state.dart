import 'package:spark/business_logic/models/interests_model.dart';

abstract class InterestsState {
  double progress;
  InterestsState({required this.progress});

}

class InterestsInitialState extends InterestsState {
  InterestsInitialState():super(progress: 0);
}

class InterestsLoadingState extends InterestsState {
  InterestsLoadingState(double progress):super(progress: progress);
}
class InterestsLoadedState extends InterestsState {
  InterestsLoadedState(double progress):super(progress: progress);
}
class FieldsInputState extends InterestsState{
  List<InterestCategory> interestCategoriesList;
  List<String> userIntersts;
  FieldsInputState(double progress, this.interestCategoriesList, this.userIntersts): super(progress: progress);
}

class WorkoutInputState extends InterestsState{
  String selectedInterest;
  WorkoutInputState(double progress, this.selectedInterest): super(progress: progress);
}

class StarSignInputState extends InterestsState{
  String selectedStarSign;
  StarSignInputState(double progress, this.selectedStarSign): super(progress: progress);
}

class EducationInputState extends InterestsState{
  String selectedEdu;
  EducationInputState(double progress, this.selectedEdu): super(progress: progress);
}
class DrinkInputState extends InterestsState{
  String selectedDrinkFreq;
  DrinkInputState(double progress,this.selectedDrinkFreq ): super(progress: progress);
}
class SmokeInputState extends InterestsState{
  String smokeFreq;
  SmokeInputState(double progress, this.smokeFreq): super(progress: progress);
}

class PoliticalInputState extends InterestsState{
  String politicalInterest;
  PoliticalInputState(double progress, this.politicalInterest): super(progress: progress);
}
class AboutInputState extends InterestsState{
  AboutInputState(double progress): super(progress: progress);
}

class IntrestsSavedSuccessState extends InterestsState{
  IntrestsSavedSuccessState(double progress): super(progress: progress);
}
class IntrestsFaildToSaveState extends InterestsState{
  IntrestsFaildToSaveState(double progress): super(progress: progress);
}