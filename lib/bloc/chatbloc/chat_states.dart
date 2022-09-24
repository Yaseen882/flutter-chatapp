import 'package:flutter/material.dart';

import '../../model/chat_model.dart';

@immutable
abstract class ChatState {
  const ChatState();
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<ChatModel> listOfChat;

  const ChatLoadedState({required this.listOfChat});
}

class ChatErrorState extends ChatState {
  final String msg;

  const ChatErrorState({required this.msg});
}
