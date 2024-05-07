import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/mail_id/auth_event.dart';
import 'package:spark/business_logic/blocs/authenticate/mail_id/auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates>{
  AuthBloc():super(AuthInitialState()){
    on<GoogleSignInEvent>((event, emit) => googleSignInEvent(event, emit));
    on<AppleIdSignInEvent>((event, emit) =>appleIdSignInEvent(event, emit) );
  }
  
  googleSignInEvent(GoogleSignInEvent event, Emitter<AuthStates> emit) {
    debugPrint("Google sing in");
  }
  
  appleIdSignInEvent(AppleIdSignInEvent event, Emitter<AuthStates> emit) {
     debugPrint("Apple sing in");
  }
}