import 'package:bloc/bloc.dart';
import 'package:spark/business_logic/blocs/splash/splash_events.dart';
import 'package:spark/business_logic/blocs/splash/splash_state.dart';

class SplashBloc extends Bloc<SplashEvents, SplashState>{
  SplashBloc():super(InitialAppState()){
    on<AppStartedEvent>((event, emit) => appStartedEvent(event, emit));
  }
  
  appStartedEvent(AppStartedEvent event, Emitter<SplashState> emit) async{
    await Future.delayed(const Duration( seconds: 3));
    //check if user is already signed in or new useer and navigate accordingly using api call
    //an api call required here
    emit(AuthenticateState(false));

  }
}