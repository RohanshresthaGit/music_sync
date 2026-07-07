class RefreshTokenResponseModel {
  final String accessToken;
  final String refreshToken;
  final String? tokenType;

  const RefreshTokenResponseModel({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType,
  });

  factory RefreshTokenResponseModel.fromJson(dynamic json) {
    final payload = json is Map
        ? Map<String, dynamic>.from(json)
        : <String, dynamic>{};

    return RefreshTokenResponseModel(
      accessToken:
          (payload['accessToken'] ?? payload['access_token'])?.toString() ?? '',
      refreshToken:
          (payload['refreshToken'] ?? payload['refresh_token'])?.toString() ??
          '',
      tokenType: (payload['tokenType'] ?? payload['token_type'])?.toString(),
    );
  }
}
