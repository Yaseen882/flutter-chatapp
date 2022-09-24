import 'package:flutter/material.dart';
import '../../model/chat_model.dart';
@immutable
abstract class ChatEvents{
  const ChatEvents();
}
class ChatViewEvent extends ChatEvents{
  final ChatModel chatModel;
  const ChatViewEvent({required this.chatModel});
}
class ChatBtnEvent extends ChatEvents{
 final ChatModel chatModel;
 const ChatBtnEvent({required this.chatModel});

}