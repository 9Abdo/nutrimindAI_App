class UserModel {
  final String fullname;
  final String email;

  UserModel({
    required this.fullname,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullname: json["fullname"] ?? "",
      email: json["email"] ?? "",
    );
  }
}