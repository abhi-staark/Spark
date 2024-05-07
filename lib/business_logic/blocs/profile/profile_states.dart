abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileLoadedState extends ProfileStates {
  List premiumList = [
    {
      "title": "Premium",
      "description":
          "Enjoy exclusive features and unlock unlimited possibilities."
    },
    {
      "title": "Boost",
      "description":
          "Get enhanced visibility, more matches, and supercharge your connections."
    }
  ];
  
  final List featuesList;
  ProfileLoadedState(this.featuesList);
}

class ProfileErrorState extends ProfileStates {
  String errorMessage;
  ProfileErrorState(this.errorMessage);
}
