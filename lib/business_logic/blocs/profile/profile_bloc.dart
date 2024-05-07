import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/profile/profile_events.dart';
import 'package:spark/business_logic/blocs/profile/profile_states.dart';
import 'package:spark/business_logic/repositories/pofile_repo.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<UpgradePreiumEvent>((event, emit) => upgradePreiumEvent(event, emit));
    on<EditProfileEvent>((event, emit) => editProfileEvent(event, emit));
    on<LoadUserDetailsDataEvent>(
        (event, emit) => loadUserDetailsDataEvent(event, emit));
  }

  loadUserDetailsDataEvent(
      LoadUserDetailsDataEvent event, Emitter<ProfileStates> emit) async {
    emit(ProfileLoadingState());
    ProfileRepo profileRepo = ProfileRepo();
    try {
    //dynamic responseData =await profileRepo.loadUserData();
    await Future.delayed(const Duration(seconds: 3));
    emit(ProfileLoadedState(await profileRepo.getFeaturePlans()));
    } catch (error) {
      ProfileErrorState(error.toString());
    }
  }

  upgradePreiumEvent(UpgradePreiumEvent event, Emitter<ProfileStates> emit) {}
  editProfileEvent(EditProfileEvent event, Emitter<ProfileStates> emit) {}
}
