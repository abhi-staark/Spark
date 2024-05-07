import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/landing/landing_event.dart';
import 'package:spark/business_logic/blocs/landing/landing_state.dart';

class LandingBloc extends Bloc<LandingEvents, LandingStates>{

  LandingBloc():super(LandingLoadedState(1)){
    on<UpdateBottomNavItemEventItem>((event, emit) => updateBottomNavItemEventItem(event, emit));
  }
  
  updateBottomNavItemEventItem(UpdateBottomNavItemEventItem event, Emitter<LandingStates> emit) {
     emit(LandingLoadedState(event.index));
  }

}