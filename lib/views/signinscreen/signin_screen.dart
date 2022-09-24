import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychatapp/bloc/signin/signin_bloc.dart';
import 'package:mychatapp/bloc/signin/signin_sate.dart';
import 'package:mychatapp/firebase/authentication.dart';
import 'package:mychatapp/views/home/home_screen.dart';
import '../../controller/signin_controller.dart';
import '../../controller/signup_controller.dart';
import '../customwidget/inputfield_cutom_widget.dart';
import '../signupscreen/signup_screen.dart';
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SignInWidget(),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SignInLoadedState) {

                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));


                });
              } else if (state is SignInErrorState) {
                Fluttertoast.showToast(msg: state.msg);
              } else {
                return const SizedBox();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class SignInWidget extends StatelessWidget {
  SignInWidget({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const SizedBox(height: 50),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const
              SignUpScreen(),));
            }, child: const Text('Create Account')),

          ],
        ),
      ),
    );
  }

  Widget btnSignUp(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            btnSignInClick(
              context: context,
              email: emailController.text,
              password: passwordController.text,
            );
          }
        },
        child: const Center(child: Text('SignIn')));
  }
}
