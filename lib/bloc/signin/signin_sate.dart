import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


@immutable
abstract class SignInState{
  const SignInState();
}
class SignInInitialState extends SignInState{}
class SignInLoadingState extends SignInState{}
class SignInLoadedState extends SignInState{
  final User user;
  const SignInLoadedState({required this.user});

}
class SignInErrorState extends SignInState{
  final String msg;
  const SignInErrorState({required this.msg});
}
