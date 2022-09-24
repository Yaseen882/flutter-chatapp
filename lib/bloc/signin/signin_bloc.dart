import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychatapp/bloc/signin/signin_event.dart';
import 'package:mychatapp/bloc/signin/signin_sate.dart';
import '../../firebase/authentication.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState>{
   SignInBloc():super(SignInInitialState()){
     on<SignInEvent>((event, emit) async {
       if(event is BtnSignInEvent){
         emit.call(SignInLoadingState());
         try{
           User? user = await userSignIn(event.email,event.password);
           emit.call(SignInLoadedState(user: user!));
         }on FirebaseAuthException catch(error){
           switch(error.code){
             case 'invalid-email':
                return emit.call(const SignInErrorState(msg: 'Invalid email'));
             case 'user-disabled':
               return emit.call(const SignInErrorState(msg: 'User disabled'));
             case 'user-not-found':
               return emit.call(const SignInErrorState(msg: 'User not found'));
             case 'wrong-password':
               return emit.call(const SignInErrorState(msg: 'Wrong password'));
               default:
                 return emit.call(const SignInErrorState(msg: 'Something went wrong'));
           }

         }

       }
     });
   }
}