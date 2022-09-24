import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychatapp/bloc/users/user_bloc.dart';
import 'package:mychatapp/bloc/users/user_event.dart';
import 'package:mychatapp/bloc/users/user_states.dart';
import 'package:mychatapp/firebase/authentication.dart';
import 'package:mychatapp/views/chatscreen/chat_screen.dart';
import 'package:provider/provider.dart';
import '../../model/user_model.dart';
import '../signinscreen/signin_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserBloc bloc = Provider.of<UserBloc>(context,listen: false);
    bloc.add(FetchUserEvent());
    return Scaffold(
        appBar: AppBar(
          title: const Text('ChatApp'),
          actions: [
            IconButton(
              onPressed: ()  {
                 signout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              },
              icon: const Icon(Icons.login_outlined),
            ),
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserLoadedState) {
              return UserLoadedWidget(listOfUser: state.list);
            } else if (state is UserErrorState) {
              Fluttertoast.showToast(msg: state.msg);
            } else {
              return const SizedBox();
            }
            return const SizedBox();
          },
        ));
  }
}

class UserLoadedWidget extends StatelessWidget {
  final List<UserModel> listOfUser;


  const UserLoadedWidget({Key? key, required this.listOfUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = listOfUser[index];
          if(userModel.id != auth.currentUser!.uid){
              return userView(userModel, context);
          }else{
            return const SizedBox();
          }

        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          );
        },
        itemCount: listOfUser.length);
  }
  Widget userView(UserModel userModel,BuildContext context){
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(userModel: userModel),));
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(userModel.name),
    );
  }
}
