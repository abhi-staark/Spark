abstract class LandingStates{
  int currentIndex;
  LandingStates(this.currentIndex);
}
class LandingInitialState extends LandingStates{
  LandingInitialState(int currentIndex): super(currentIndex);
}
class LandingLoadingState extends LandingStates{
  LandingLoadingState(int currentIndex): super(currentIndex);
}
class LandingLoadedState extends LandingStates{
  LandingLoadedState(int currentIndex): super(currentIndex);
}
class LandingErrorState extends LandingStates{
  LandingErrorState(int currentIndex): super(currentIndex);
}
// //screens
// class ProfileState extends LandingStates{
//   ProfileState(int currentIndex): super(currentIndex);
// }
// class SubscriptionState extends LandingStates{
//   SubscriptionState(int currentIndex): super(currentIndex);
// }
// class HomeState extends LandingStates{
//   HomeState(int currentIndex): super(currentIndex);
// }
// class LikesState extends LandingStates{
//   LikesState(int currentIndex): super(currentIndex);
// }
// class ChatState extends LandingStates{
//   ChatState(int currentIndex): super(currentIndex);
// }


