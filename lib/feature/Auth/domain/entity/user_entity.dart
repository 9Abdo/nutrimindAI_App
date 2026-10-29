class UserEntity {
 
  final String uid;
  final String fullname;
  final String email;
  final String? profileImage;
  final DateTime? createdAt;

  UserEntity({
    required this.uid,
    required this.fullname,
    required this.email,
    this.profileImage,
    this.createdAt,
  });
}