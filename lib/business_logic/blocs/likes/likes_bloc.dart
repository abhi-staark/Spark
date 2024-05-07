import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/likes/likes_events.dart';
import 'package:spark/business_logic/blocs/likes/likes_states.dart';
import 'package:spark/business_logic/models/user.dart';
import 'package:spark/business_logic/repositories/like_repo.dart';

class LikesBloc extends Bloc<LikeEvents, LikeStates>{
  LikesBloc(): super(LikesInitialState()){
    on<LoadLikesEvent>((event, emit) => loadLikesEvent(event, emit));

  }
  loadLikesEvent(LoadLikesEvent event, Emitter<LikeStates> emit)async{
    emit(LikesLoadingSate());
    LikesRepo likesRepo = LikesRepo();
    try{
    List<User> likesList= await likesRepo.getLikesList();
    debugPrint("Likes length: ${likesList.length}");
    emit(LikesLoadedState(likesList));
    }
    catch(error){
      emit(LikesErrorState(error.toString()));
    }
  
  }
  
}