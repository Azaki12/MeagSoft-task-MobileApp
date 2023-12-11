class ProfileData {
  String? id;
  String? role;
  String? email;
  String? name;
  ProfileData({
    this.id,
    this.role,
    this.email,
    this.name,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
      );
}
