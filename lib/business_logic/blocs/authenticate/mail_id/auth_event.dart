import 'package:flutter/material.dart';

abstract class AuthEvents{}

class GoogleSignInEvent extends AuthEvents{
  BuildContext context;
  GoogleSignInEvent(this.context);
}

class AppleIdSignInEvent extends AuthEvents{
  BuildContext context;
  AppleIdSignInEvent(this.context);
}
