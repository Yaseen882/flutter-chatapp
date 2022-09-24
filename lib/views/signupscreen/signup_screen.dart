import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychatapp/bloc/signup/signup_state.dart';
import 'package:mychatapp/controller/signup_controller.dart';
import 'package:mychatapp/views/customwidget/inputfield_cutom_widget.dart';
import 'package:mychatapp/views/signinscreen/signin_screen.dart';

import '../../bloc/signup/signup_bloc.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SignUpWidget(),
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpInitialState) {
                return const SizedBox();
              } else if (state is SignUpLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SignUpLoadedState) {
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                });
              } else if (state is SignUpErrorState) {
                return SignUpErrorWidget(
                  errorMsg: state.msg,
                );
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

class SignUpWidget extends StatelessWidget {
  SignUpWidget({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFieldWidget(
              hintText: 'Name',
              icon: Icons.person,
              controller: nameController,
              height: 45,
              width: double.infinity,
              autoFocus: false,
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              hintText: 'Email',
              icon: Icons.email,
              controller: emailController,
              height: 45,
              width: double.infinity,
              autoFocus: false,
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              hintText: 'password',
              icon: Icons.lock,
              controller: passwordController,
              height: 45,
              width: double.infinity,
              autoFocus: false,
            ),
            const SizedBox(height: 50),
            btnSignUp(context),
          ],
        ),
      ),
    );
  }

  Widget btnSignUp(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            btnSignUpClick(
                context: context,
                email: emailController.text,
                password: passwordController.text,
                name: nameController.text);
          }
        },
        child: const Center(child: Text('SignUp')));
  }
}

class SignUpErrorWidget extends StatelessWidget {
  final String errorMsg;

  const SignUpErrorWidget({Key? key, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMsg),
      ),
    );
  }
}
