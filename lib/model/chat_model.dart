class ChatModel {
  String to;
  String from;
  String msg;
  var time;

  ChatModel({
    required this.msg,
    required this.from,
    required this.time,
    required this.to,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      msg: map['msg'],
      from: map['from'],
      time: map['time'],
      to: map['to'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'from': from,
      'to': to,
      'time': time,
    };
  }
}
