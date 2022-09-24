import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychatapp/bloc/signup/signup_event.dart';
import 'package:mychatapp/bloc/signup/signup_state.dart';

import '../../firebase/authentication.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEvent>((event, emit) async {
      if (event is BtnSignUpEvent) {
        emit.call(SignUpLoadingState());
        try {
          User? user =
          await userSignUp(event.email, event.password, event.name);
          emit.call(SignUpLoadedState(user));
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case 'email-already-in-use':
              return emit.call(const SignUpErrorState(msg: 'This email already exist'));
            case 'invalid-email':
              return emit.call(const SignUpErrorState(msg: 'Invalid email'));
            case 'weak-password':
              return  emit.call(const SignUpErrorState(msg: 'Weak password'));
            default:
              return emit.call(const SignUpErrorState(msg: 'Default Message'));
          }
        }
      }
    });
  }
}
