import 'package:spark/business_logic/models/user.dart';

abstract class HomeEvents {}

class LoadMatchesEvent extends HomeEvents {}

class RightSwipeEvent extends HomeEvents {
  User user;
  RightSwipeEvent({required this.user});
}

class LeftSwipeEvent extends HomeEvents {
  User user;
  LeftSwipeEvent({required this.user});
}

class SuperSwipeEvent extends HomeEvents {
  User user;
  SuperSwipeEvent({required this.user});
}

class ReachedEndOfListEvent extends HomeEvents {}
