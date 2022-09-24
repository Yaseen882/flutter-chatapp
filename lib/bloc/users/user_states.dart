import 'package:flutter/material.dart';
import 'package:mychatapp/model/user_model.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitialState extends UserState {}
class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> list;

  const UserLoadedState({required this.list});
}

class UserErrorState extends UserState {
  final String msg;

  const UserErrorState({required this.msg});
}
