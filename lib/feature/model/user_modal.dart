import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullname;
  final String email;
  final String? profileImage;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    this.profileImage,
    this.createdAt,
  });

  factory UserModel.fromFirestore(
    Map<String, dynamic> data,
    String uid,
  ) {
    final createdAtData = data["createdAt"];

    return UserModel(
      uid: uid,
      fullname: data["fullname"] ?? "",
      email: data["email"] ?? "",
      profileImage: data["profileImage"],
      createdAt: createdAtData is Timestamp
          ? createdAtData.toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "fullname": fullname,
      "email": email,
      "profileImage": profileImage,
      "createdAt": createdAt == null
          ? Timestamp.now()
          : Timestamp.fromDate(createdAt!),
    };
  }
}