import 'package:flutter/material.dart';
import 'package:mychatapp/bloc/chatbloc/chat_bloc.dart';
import 'package:mychatapp/bloc/chatbloc/chat_events.dart';
import 'package:mychatapp/model/chat_model.dart';
import 'package:provider/provider.dart';

void btnClick({required BuildContext context,required String msg,required var time,required String from,required String to}){
  ChatBloc bloc = Provider.of<ChatBloc>(context,listen: false);
  bloc.add(ChatBtnEvent(chatModel: ChatModel(msg: msg, from: from, time: time, to: to)));
}