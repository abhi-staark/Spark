abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeLoadingState extends HomeStates{}

class HomeLoadedState extends HomeStates{
  List matchesList;
  HomeLoadedState({required this.matchesList});
  
}

class HomeErrorState extends HomeStates{
  String errorMessage;
  HomeErrorState(this.errorMessage);

}

