import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/home/home_event.dart';
import 'package:spark/business_logic/blocs/home/home_state.dart';
import 'package:spark/business_logic/models/user.dart';
import 'package:spark/business_logic/repositories/home_repo.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadMatchesEvent>((event, emit) => loadMatchesEvent(event, emit));
    on<LeftSwipeEvent>(((event, emit) => leftSwipeEvent(event, emit)));
    on<RightSwipeEvent>((event, emit) => rightSwipeEvent(event, emit));
    on<ReachedEndOfListEvent>((event, emit) => reachedEndOfListEvent(event, emit));
  }

  loadMatchesEvent(LoadMatchesEvent event, Emitter<HomeStates> emit) async {
    emit(HomeLoadingState());
    HomeRepository homeRepository = HomeRepository();
    try{
      List<User> matchesList = await homeRepository.fetchMatchesList();
      emit(HomeLoadedState(matchesList: matchesList));
    }catch(error){
      emit(HomeErrorState(error.toString()));
    }
  
    
  }

  leftSwipeEvent(LeftSwipeEvent event, Emitter<HomeStates> emit){
    debugPrint("User swiped left: ${event.user.userName}");
  }

  rightSwipeEvent(RightSwipeEvent event, Emitter<HomeStates> emit){
    debugPrint("User swiped right: ${event.user.userName} ");
  }

  reachedEndOfListEvent(ReachedEndOfListEvent event, Emitter<HomeStates> emit){
    debugPrint("Reached end of list");
  }
}
