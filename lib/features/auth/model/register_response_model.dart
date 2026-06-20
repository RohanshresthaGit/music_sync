class RegisterResponseModel {
  final String userId;
  final String email;
  final String username;
  final bool emailVerified;

  const RegisterResponseModel({
    required this.userId,
    required this.email,
    required this.username,
    required this.emailVerified,
  });

  factory RegisterResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return RegisterResponseModel(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      emailVerified: json['emailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'emailVerified': emailVerified,
    };
  }
}