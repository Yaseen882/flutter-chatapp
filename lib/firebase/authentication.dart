import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseAuth auth = FirebaseAuth.instance;
Future<User?> userSignUp(String email,String password, String name) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
  User? user = credential.user;
  if(credential.user != null){
    sendUserOtherData(credential.user!.uid, name);
  }
  return user;
}

Future<void> sendUserOtherData(String uId,String name) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('users').doc(uId).set({'name':name, 'uId' : uId});

}
Future<User?> userSignIn(String email,String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
  User? user = credential.user;

  return user;
}
Future signout() async {
  await auth.signOut();
}
