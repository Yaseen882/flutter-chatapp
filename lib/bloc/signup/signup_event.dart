import 'package:flutter/foundation.dart';

@immutable
abstract class SignUpEvent{
  const SignUpEvent();
}
class BtnSignUpEvent extends SignUpEvent{
  final String email;
  final String password;
  final String name;
  const BtnSignUpEvent({required this.email, required this.password,required this.name});
}