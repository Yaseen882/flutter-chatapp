import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychatapp/bloc/chatbloc/chat_bloc.dart';
import 'package:mychatapp/bloc/chatbloc/chat_states.dart';
import 'package:mychatapp/controller/chat_controller.dart';
import 'package:mychatapp/firebase/authentication.dart';
import 'package:mychatapp/model/chat_model.dart';
import 'package:mychatapp/model/user_model.dart';

class ChatScreen extends StatelessWidget {
  final UserModel userModel;

  const ChatScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userModel.name),),
      body: Stack(
        children: [
          BuildChatBottomView(to: userModel.id),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoadingState) {
                //yaseen khan
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ChatLoadedState) {
                ChatListWidget(list: state.listOfChat);
              } else if (state is ChatErrorState) {
                Fluttertoast.showToast(msg: state.msg);
              } else {
                return const SizedBox();
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}

class ChatListWidget extends StatelessWidget {
  final List<ChatModel> list;

  ChatListWidget({Key? key, required this.list}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var listOfChat = list[index];
        String sender = listOfChat.from;

        if (auth.currentUser!.uid == sender) {
          return senderView(listOfChat);
        } else {
          return reciverView(listOfChat);
        }
      },
    );
  }

  Widget senderView(ChatModel model) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 100,
        child: Row(
          children: [
            Text(model.msg),
            const SizedBox(
              width: 10,
            ),
            // Text('${model.time}')
          ],
        ),
      ),
    );
  }

  Widget reciverView(ChatModel model) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 100,
        child: Row(
          children: [
            Text(model.msg),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildChatBottomView extends StatelessWidget {
  final String to;

  BuildChatBottomView({Key? key, required this.to}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.photo),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions),
              ),
              SizedBox(
                width: 200,
                child: Center(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  btnClick(
                      context: context,
                      msg: controller.text,
                      time: DateTime.now(),
                      from: auth.currentUser!.uid,
                      to: to);
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ),
      ),
    );
  }
}
