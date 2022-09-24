import 'package:flutter/widgets.dart';
import 'package:mychatapp/bloc/signup/signup_bloc.dart';
import 'package:mychatapp/bloc/signup/signup_event.dart';
import 'package:provider/provider.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

void btnSignUpClick(
    {required BuildContext context,
    required String email,
    required String password,
    required String name}) {
  SignUpBloc bloc = Provider.of<SignUpBloc>(context, listen: false);
  bloc.add(BtnSignUpEvent(email: email, password: password, name: name));
}


