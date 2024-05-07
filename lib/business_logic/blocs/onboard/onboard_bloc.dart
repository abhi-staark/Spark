import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_event.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_state.dart';
import 'package:spark/services/app_services.dart';
import 'package:spark/utils/alerts/snack_bar.dart';
import 'package:spark/utils/constants/asset_path.dart';
import 'package:spark/utils/permissions/app_permission_service.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  String name = '';
  String age = '0';
  bool switchValue = false;
  List<bool> checkboxValues = [false, false, false];
  List<String> genderValues = ['Men', 'Women', 'NonBinary'];
  List<String> selectedGenders = [];
  String datingMode = 'Date';
  List<XFile?> imageFiles = [null, null, null, null, null, null];
  OnboardingBloc() : super(NameInputState(0.20, '')) {
    on<NameSubmittedEvent>(
      (event, emit) => nameSubmittedEvent(event, emit),
    );
    on<AgeSubmittedEvent>((event, emit) => ageSubmittedEvent(event, emit));
    on<GenderSubmittedEvent>(
        (event, emit) => genderSubmittedEvent(event, emit));
    on<GenderSwitchChangedEvent>(
        (event, emit) => genderSwitchChangedEvent(event, emit));
    on<CheckboxChangedEvent>(
        (event, emit) => checkboxChangedEvent(event, emit));
    on<DatingModeChangedEvent>(
        (event, emit) => datingModeChangedEvent(event, emit));
    on<DatingModeSubmittedEvent>(
        (event, emit) => datingModeSubmittedEvent(event, emit));
    on<AddImageEvent>((event, emit) => addImageEvent(event, emit));
    on<ImagesSubmittedEvent>(
        (event, emit) => imagesSubmittedEvent(event, emit));

    //on<SubmitAllDataEvent>((event, emit) => submitAllDataEvent(event, emit));
  }

  nameSubmittedEvent(
      NameSubmittedEvent event, Emitter<OnboardingState> emit) async {
    // emit(OnboardingLoadingState(state.progress));
    //await Future.delayed(const Duration(seconds: 3));
    name = event.name;

    debugPrint("Name: ${event.name}");

    if (event.name == '') {
      debugPrint("Name is empty");
      Utils.showSnackBar(
          event.context, 'Please enter a valid Name', AssetPath.failureIcon);
      emit(NameInputState(0.20, event.name));
    } else {
      debugPrint("Going to next event");
      emit(AgeInputState(0.40));
    }
  }

  ageSubmittedEvent(
      AgeSubmittedEvent event, Emitter<OnboardingState> emit) async {
    if (event.age.length == 8) {
      // ApplicationMethods applicationServiceMethods =
      //     ApplicationMethods();
      AppServices appServices= AppServices();
      age = appServices.calculateAge(event.age);
      emit(GenderInputState(0.60, switchValue, checkboxValues));
      debugPrint("Age: $age");
    } else {
      debugPrint("Age: ${event.age}");
      debugPrint("Length: ${event.age.length}");
      Utils.showSnackBar(
          event.context, 'Please enter correct Age', AssetPath.failureIcon);
    }
  }

  genderSubmittedEvent(
      GenderSubmittedEvent event, Emitter<OnboardingState> emit) {
    for (int i = 0; i < checkboxValues.length; i++) {
      if (checkboxValues[i]) {
        selectedGenders.add(genderValues[i]);
      }
    }
    if (selectedGenders.isEmpty) {
      Utils.showSnackBar(
          event.context, 'Please select field', AssetPath.failureIcon);
    } else {
      emit(DatingModeInputState(0.80, datingMode));
    }
  }

  genderSwitchChangedEvent(
      GenderSwitchChangedEvent event, Emitter<OnboardingState> emit) {
    switchValue = event.switchValue;
    if (switchValue == true) {
      //selectedGenders=genderValues;
      checkboxValues = [true, true, true];
      emit(GenderInputState(state.progress, switchValue, checkboxValues));
    } else {
      emit(GenderInputState(state.progress, switchValue, checkboxValues));
    }
  }

  checkboxChangedEvent(
      CheckboxChangedEvent event, Emitter<OnboardingState> emit) {
    checkboxValues[event.index] = !(checkboxValues[event.index]);
    if (checkboxValues.every((element) => (element == true))) {
      switchValue = true;
      emit(GenderInputState(state.progress, switchValue, checkboxValues));
    } else if (checkboxValues.any((element) => (element == false))) {
      switchValue = false;
      emit(GenderInputState(state.progress, switchValue, checkboxValues));
    }
  }

  datingModeChangedEvent(
      DatingModeChangedEvent event, Emitter<OnboardingState> emit) {
    emit(DatingModeInputState(0.80, event.mode));
  }

  datingModeSubmittedEvent(
      DatingModeSubmittedEvent event, Emitter<OnboardingState> emit) {
    //next state pick photos
    emit(ImagesInputState(1.00, [null, null, null, null, null, null]));
  }

  addImageEvent(AddImageEvent event, Emitter<OnboardingState> emit) async {
    ApplicationPermissions appPermissions = ApplicationPermissions();
    AppServices appServices= AppServices();
    XFile? imageFile;

    if (await appPermissions.requestStoragePermission(event.context)) {
      imageFile = await appServices.pickImageFromGallery();
    }

    if (imageFile != null) {
      // Create a copy of the existing image files list
      List<XFile?> updatedImageFiles =
          List.from((state as ImagesInputState).imageFiles);

      // Add the new image file at the specified index
      updatedImageFiles.removeAt(event.index);
      updatedImageFiles.insert(event.index, imageFile);
      imageFiles = updatedImageFiles;

      // Emit a new state with the updated list of image files
      emit(ImagesInputState(1, updatedImageFiles));
    }
  }

  imagesSubmittedEvent(
      ImagesSubmittedEvent event, Emitter<OnboardingState> emit) async {
    emit(OnboardingLoadingState(state.progress));
    if (imageFiles.where((element) => element != null).length >= 2) {
      debugPrint("Name: $name");
      debugPrint("Age: $age");
      debugPrint("selectedGenders: $selectedGenders");
      debugPrint("datingMode: $datingMode");
      debugPrint("imageFiles: $imageFiles");
      await Future.delayed(const Duration(seconds: 3)); //make api call
      emit(OnBoardingSuccessState());
    } else {
      emit(ImagesInputState(state.progress, imageFiles));
      Utils.showSnackBar(
          event.context, 'Upload atleast 2 images.', AssetPath.failureIcon);
    }
  }
}
