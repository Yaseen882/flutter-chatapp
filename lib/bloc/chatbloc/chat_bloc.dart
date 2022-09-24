import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychatapp/bloc/chatbloc/chat_events.dart';
import 'package:mychatapp/bloc/chatbloc/chat_states.dart';
import 'package:mychatapp/firebase/firestore_db.dart';
import 'package:mychatapp/model/chat_model.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    on<ChatEvents>((event, emit) async {
      if (event is ChatBtnEvent) {
        emit.call(ChatLoadingState());
        try {
          List<ChatModel> list = await messageClosure(event.chatModel);
          emit.call(ChatLoadedState(listOfChat: list));
        } on FirebaseException catch (error) {
          emit.call(ChatErrorState(msg: '${error.message}'));
        }
      }else if(event is ChatViewEvent){
        emit.call(ChatLoadingState());
        try{
          var list = await fetchMessages(event.chatModel);
          emit.call(ChatLoadedState(listOfChat: list));
        } on FirebaseException catch(error){
          emit.call(ChatErrorState(msg: '${error.message}'));
        } catch(error){
          emit.call(ChatErrorState(msg: error.toString()));
        }
      }
    });
  }
}
