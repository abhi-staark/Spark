abstract class SplashState{
  bool isSignedin;
  SplashState({required this.isSignedin});

}

class InitialAppState extends SplashState{
  InitialAppState():super(isSignedin: false);
}

class AuthenticateState extends SplashState{
  AuthenticateState(bool isSignedin): super(isSignedin: isSignedin);

}
// class SignedInState extends SplashState{
//   SignedInState({required super.isSignedin});
// }

// class SignedOutState extends SplashState{
//   SignedOutState({required super.isSignedin});
// }