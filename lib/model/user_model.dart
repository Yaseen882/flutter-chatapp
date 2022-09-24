class UserModel {
  String id;
  String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromMap(var map) {
    return UserModel(
      id: map['uId'],
      name: map['name'],
    );
  }
}
