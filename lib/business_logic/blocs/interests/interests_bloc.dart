import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/business_logic/models/interests_model.dart';
import 'package:spark/business_logic/repositories/interests_repo.dart';
import 'package:spark/utils/alerts/snack_bar.dart';
import 'package:spark/utils/constants/asset_path.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc() : super(InterestsInitialState()) {
    on<LoadInterestsEvent>((event, emit) => loadInterestsEvent(event, emit));
    on<SelectInterestEvent>((event, emit) => selectInterestEvent(event, emit));
    on<FieldsInterestsSubmittedEvent>(
        (event, emit) => fieldsInterestsSubmittedEvent(event, emit));
    //workout
    on<WorkoutInterestSelectedEvent>(
        (event, emit) => workoutInterestSelectedEvent(event, emit));
    on<WorkoutInterestSubmittedEvent>(
        (event, emit) => workoutInterestSubmittedEvent(event, emit));
    //star sign
    on<StarSignInterestSelectedEvent>(
        (event, emit) => starSignInterestSelectedEvent(event, emit));
    on<StarSignInterestSubmittedEvent>(
        (event, emit) => starSignInterestSubmittedEvent(event, emit));
    //education
    on<EducationInterestSelectedEvent>(
        (event, emit) => educationInterestSelectedEvent(event, emit));
    on<EducationInterestSubmittedEvent>(
        (event, emit) => educationInterestSubmittedEvent(event, emit));
    //drink
    on<DrinkInterestSelectedEvent>(
        (event, emit) => drinkInterestSelectedEvent(event, emit));
    on<DrinkInterestSubmittedEvent>(
        (event, emit) => drinkInterestSubmittedEvent(event, emit));
    //smoke
    on<SmokeInterestSelectedEvent>(
        (event, emit) => smokeInterestSelectedEvent(event, emit));
    on<SmokeInterestSubmittedEvent>(
        (event, emit) => smokeInterestSubmittedEvent(event, emit));
    //political
    on<PoliticalInterestSelectedEvent>(
        (event, emit) => politicalInterestSelectedEvent(event, emit));
    on<PoliticalInterestSubmittedEvent>(
        (event, emit) => politicalInterestSubmittedEvent(event, emit));
    on<AboutInterestSubmittedEvent>(
        (event, emit) => aboutInterestSubmittedEvent(event, emit));
  }
  List<String> tempInterestList = [];
  String workoutRoutine = 'Active';
  String starSign = 'Aries';
  String educationLevel = 'Undergraduate Degree';
  String drinkFreq = 'Socially';
  String smokeFreq = 'Socially';
  String politicalIn = 'Independent';
  String aboutInfo = '';

  loadInterestsEvent(
      LoadInterestsEvent event, Emitter<InterestsState> emit) async {
    emit(InterestsLoadingState(0.125));
    InterestsRepo interestsRepo = InterestsRepo();
    try {
      List<InterestCategory> categories =
          await interestsRepo.fetchInterestCategories();
      emit(FieldsInputState(0.125, categories, []));
    } catch (error) {
      print(error);
      //emit(InterestsErrorState(error.toString()));
    }
  }

  selectInterestEvent(SelectInterestEvent event, Emitter<InterestsState> emit) {
    //also need to add condition not more than 5
    if (tempInterestList.contains(event.interest)) {
      tempInterestList.remove(event.interest);
    } else {
      tempInterestList.add(event.interest);
    }
    print(tempInterestList);
    emit(FieldsInputState(
        state.progress, event.interestCategoriesList, tempInterestList));
  }

  fieldsInterestsSubmittedEvent(
      FieldsInterestsSubmittedEvent event, Emitter<InterestsState> emit) {
    if (tempInterestList.length >= 5) {
      debugPrint("Good to go");
      emit(WorkoutInputState(0.250, workoutRoutine));
    } else {
      Utils.showSnackBar(
          event.context, 'Please select 5 interests', AssetPath.failureIcon);
    }
  }

  workoutInterestSelectedEvent(
      WorkoutInterestSelectedEvent event, Emitter<InterestsState> emit) {
    workoutRoutine = event.selectedInterest;
    emit(WorkoutInputState(0.250, workoutRoutine));
  }

  workoutInterestSubmittedEvent(
      WorkoutInterestSubmittedEvent event, Emitter<InterestsState> emit) {
    debugPrint("Selected Field: $workoutRoutine");
    emit(StarSignInputState(0.375, starSign));
  }

  starSignInterestSelectedEvent(
      StarSignInterestSelectedEvent event, Emitter<InterestsState> emit) {
    starSign = event.selectedStarSign;
    emit(StarSignInputState(0.375, starSign));
  }

  starSignInterestSubmittedEvent(
      StarSignInterestSubmittedEvent event, Emitter<InterestsState> emit) {
    debugPrint("Selected Sign: $starSign");
    emit(EducationInputState(0.500, educationLevel));
  }

  educationInterestSelectedEvent(
      EducationInterestSelectedEvent event, Emitter<InterestsState> emit) {
    educationLevel = event.selectEduLevel;
    emit(EducationInputState(0.500, educationLevel));
  }

  educationInterestSubmittedEvent(
      EducationInterestSubmittedEvent event, Emitter<InterestsState> emit) {
    debugPrint("Selected Education level: $educationLevel");
    emit(DrinkInputState(0.625, drinkFreq));
  }

  drinkInterestSelectedEvent(
      DrinkInterestSelectedEvent event, Emitter<InterestsState> emit) {
    drinkFreq = event.drinkFreq;
    emit(DrinkInputState(0.625, drinkFreq));
  }

  drinkInterestSubmittedEvent(
      DrinkInterestSubmittedEvent event, Emitter<InterestsState> emit) {
    debugPrint("Selected drink Freq: $drinkFreq");
    emit(SmokeInputState(0.750, smokeFreq));
  }

  smokeInterestSelectedEvent(
      SmokeInterestSelectedEvent event, Emitter<InterestsState> emit) {
    smokeFreq = event.smokeFreq;
    emit(SmokeInputState(0.750, smokeFreq));
  }

  smokeInterestSubmittedEvent(
      SmokeInterestSubmittedEvent event, Emitter<InterestsState> emit) {
    debugPrint("Selected smoke Freq: $smokeFreq");
    emit(PoliticalInputState(0.875, politicalIn));
  }

  politicalInterestSelectedEvent(
      PoliticalInterestSelectedEvent event, Emitter<InterestsState> emit) {
    politicalIn = event.politicalInterest;
    emit(PoliticalInputState(0.875, politicalIn));
  }

  politicalInterestSubmittedEvent(
      PoliticalInterestSubmittedEvent event, Emitter<InterestsState> emit) {
    debugPrint("Selected political In: $politicalIn");
    emit(AboutInputState(1));
  }

  aboutInterestSubmittedEvent(
      AboutInterestSubmittedEvent event, Emitter<InterestsState> emit) async{
    debugPrint("About infor : ${event.aboutinfo}");
    if (event.aboutinfo == '') {
      Utils.showSnackBar(
          event.context, 'Please enter about yourself.', AssetPath.failureIcon);
    } else {
      aboutInfo=event.aboutinfo;
      //make api calls for success fully fetching data
      debugPrint("Workout Routine: $workoutRoutine");
      debugPrint("Star Sign: $starSign");
      debugPrint("Education Level: $educationLevel");
      debugPrint("Drink Frequency: $drinkFreq");
      debugPrint("Smoke Frequency: $smokeFreq");
      debugPrint("Political Leaning: $politicalIn");
      debugPrint("About Info: $aboutInfo");
      emit(InterestsLoadingState(1));
      await Future.delayed(const Duration(seconds: 3));
     emit(IntrestsSavedSuccessState(1));
    }
  }
}
