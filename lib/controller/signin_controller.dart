import 'package:flutter/material.dart';
import 'package:mychatapp/bloc/signin/signin_bloc.dart';
import 'package:mychatapp/bloc/signin/signin_event.dart';
import 'package:provider/provider.dart';

void btnSignInClick({required BuildContext context,required String email,required String password}){
  SignInBloc bloc = Provider.of<SignInBloc>(context,listen: false);
  bloc.add(BtnSignInEvent(email: email, password: password));
}