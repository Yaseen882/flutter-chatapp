import 'package:flutter/material.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class FetchUserEvent extends UserEvent {}
