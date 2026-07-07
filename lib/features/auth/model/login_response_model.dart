class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  const LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenType: json['tokenType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
    };
  }
}
