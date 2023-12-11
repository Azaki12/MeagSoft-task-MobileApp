class LoginDatum {
  String? role;
  String? id;
  String? fullName;
  String? email;

  LoginDatum({
    this.id,
    this.email,
    this.role,
    this.fullName,
  });

  factory LoginDatum.fromJson(Map<String, dynamic> json) => LoginDatum(
        fullName: json['name'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
        id: json['_id'] as String?,
      );
}
