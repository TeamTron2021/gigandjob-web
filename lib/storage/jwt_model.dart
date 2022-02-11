class JwtToken {
  String token;

  JwtToken({required this.token});

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      token: json['access_token'],
    );
  }
}
