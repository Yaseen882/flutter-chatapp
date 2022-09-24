import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychatapp/bloc/chatbloc/chat_bloc.dart';
import 'package:mychatapp/bloc/signup/signup_bloc.dart';
import 'package:mychatapp/bloc/users/user_bloc.dart';
import 'package:mychatapp/views/home/home_screen.dart';
import 'package:mychatapp/views/signinscreen/signin_screen.dart';
import 'bloc/signin/signin_bloc.dart';
import 'firebase/authentication.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<SignInBloc>(create: (context) => SignInBloc()),
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
        BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: auth.currentUser != null ? const HomeScreen():const SignInScreen(),
      ),
    );
  }
}
