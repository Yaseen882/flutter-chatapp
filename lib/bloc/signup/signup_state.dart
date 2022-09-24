import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SignUpState {
  const SignUpState();
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedState extends SignUpState {
 final User? user;
 const SignUpLoadedState(this.user);
}

class SignUpErrorState extends SignUpState {
  final String msg;

  const SignUpErrorState({required this.msg});
}
