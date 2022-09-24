import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychatapp/bloc/users/user_event.dart';
import 'package:mychatapp/bloc/users/user_states.dart';
import 'package:mychatapp/firebase/firestore_db.dart';
import 'package:mychatapp/model/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<UserEvent>((event, emit) async {
      if (event is FetchUserEvent) {
        emit.call(UserInitialState());
        try {
          List<UserModel> list = await fetchUserList();
          emit.call(UserLoadedState(list: list));
        } on FirebaseException catch (error) {
          emit.call(UserErrorState(msg: '${error.message}'));
        }
      }
    });
  }
}
