import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mychatapp/model/chat_model.dart';
import 'package:mychatapp/model/user_model.dart';

Future<List<UserModel>> fetchUserList() async {
  List<UserModel> listOfUser = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var querySnapshot = await firebaseFirestore.collection('users').get();
  var listOfQuery = querySnapshot.docs;

  for (var document in listOfQuery) {
    Map<String, dynamic> map = document.data();
    var userModel = UserModel.fromMap(map);
    listOfUser.add(userModel);
  }

  return Future(() => listOfUser);
}

Future<List<ChatModel>> messageClosure(ChatModel model) async {
  await sendMessage(model);
 var list =  await fetchMessages(model);
 return Future(() => list);
}

Future<void> sendMessage(ChatModel chatModel) async {
  String groupId;
  if (chatModel.from.hashCode <= chatModel.to.hashCode) {
    groupId = '${chatModel.from}-${chatModel.to}';
  } else {
    groupId = '${chatModel.to}-${chatModel.from}';
  }
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var ref = firebaseFirestore
      .collection('messages')
      .doc(groupId)
      .collection('msg')
      .doc();
  return await ref.set(chatModel.toMap());
}

Future<List<ChatModel>> fetchMessages(ChatModel chatModel) async {
  List<ChatModel> listOfChat = [];
  String groupId;
  if (chatModel.from.hashCode <= chatModel.to.hashCode) {
    groupId = '${chatModel.from}-${chatModel.to}';
  } else {
    groupId = '${chatModel.to}-${chatModel.from}';
  }
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var querySnapShoot = await firebaseFirestore
      .collection('messages')
      .doc(groupId)
      .collection('msg')
      .orderBy('time', descending: true)
      .get();
  var listOfQuery = querySnapShoot.docs;
  for (var msg in listOfQuery) {
    Map<String, dynamic> map = msg.data();
    ChatModel model = ChatModel.fromMap(map);
    listOfChat.add(model);
  }
  return Future(() => listOfChat);
}
