import 'package:flutter/foundation.dart';

@immutable
abstract class SignInEvent {
  const SignInEvent();
}
class BtnSignInEvent extends SignInEvent{
 final String email;
 final String password;
 const BtnSignInEvent({required this.email,required this.password});
}