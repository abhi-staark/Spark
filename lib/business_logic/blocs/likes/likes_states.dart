import 'package:spark/business_logic/models/user.dart';

abstract class LikeStates{}

class LikesInitialState extends LikeStates{}

class LikesLoadingSate extends LikeStates{}

class LikesLoadedState extends LikeStates{
  List<User> likesList;
  LikesLoadedState(this.likesList);
}

class LikesErrorState extends LikeStates{
  String errorMessage;
  LikesErrorState(this.errorMessage);

}

