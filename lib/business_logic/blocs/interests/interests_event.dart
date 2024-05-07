
import 'package:flutter/material.dart';
import 'package:spark/business_logic/models/interests_model.dart';

abstract class InterestsEvent {}

class LoadInterestsEvent extends InterestsEvent {}

class SelectInterestEvent extends InterestsEvent {
  final String interest;
  List<InterestCategory> interestCategoriesList;
  SelectInterestEvent(this.interest, this.interestCategoriesList);
}

class FieldsInterestsSubmittedEvent extends InterestsEvent {
  BuildContext context;
  FieldsInterestsSubmittedEvent(this.context);

}

class WorkoutInterestSelectedEvent extends InterestsEvent{
  String selectedInterest;
  WorkoutInterestSelectedEvent(this.selectedInterest);

}


class WorkoutInterestSubmittedEvent extends InterestsEvent{
  BuildContext context;
  WorkoutInterestSubmittedEvent(this.context);

}

class StarSignInterestSelectedEvent extends InterestsEvent{
  String selectedStarSign;
  StarSignInterestSelectedEvent(this.selectedStarSign);

}


class StarSignInterestSubmittedEvent extends InterestsEvent{
  BuildContext context;
  StarSignInterestSubmittedEvent(this.context);

}

class EducationInterestSelectedEvent extends InterestsEvent{
  String selectEduLevel;
  EducationInterestSelectedEvent(this.selectEduLevel);

}


class  EducationInterestSubmittedEvent extends InterestsEvent{
  BuildContext context;
  EducationInterestSubmittedEvent(this.context);

}

class DrinkInterestSelectedEvent extends InterestsEvent{
  String drinkFreq;
  DrinkInterestSelectedEvent(this.drinkFreq);

}


class  DrinkInterestSubmittedEvent extends InterestsEvent{
  BuildContext context;
  DrinkInterestSubmittedEvent(this.context);

}

class SmokeInterestSelectedEvent extends InterestsEvent{
  String smokeFreq;
  SmokeInterestSelectedEvent(this.smokeFreq);

}


class  SmokeInterestSubmittedEvent extends InterestsEvent{
  BuildContext context;
  SmokeInterestSubmittedEvent(this.context);

}

class PoliticalInterestSelectedEvent extends InterestsEvent{
  String politicalInterest;
  PoliticalInterestSelectedEvent(this.politicalInterest);

}


class  PoliticalInterestSubmittedEvent extends InterestsEvent{
  BuildContext context;
  PoliticalInterestSubmittedEvent(this.context);
}


class  AboutInterestSubmittedEvent extends InterestsEvent{
  String aboutinfo;
  BuildContext context;
  AboutInterestSubmittedEvent(this.context, this.aboutinfo);
}

