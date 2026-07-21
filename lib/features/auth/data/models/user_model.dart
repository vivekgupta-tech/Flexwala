import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? token;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.mobile,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handling nested user data if API returns { "user": {...}, "token": "..." }
    final userData = json['user'] ?? json['data'] ?? json;
    
    // Check multiple possible token field names
    final token = json['token'] as String? ?? 
                  json['accessToken'] as String? ?? 
                  json['access_token'] as String? ??
                  userData['token'] as String? ??
                  userData['accessToken'] as String? ??
                  userData['access_token'] as String?;

    return UserModel(
      id: (userData['id'] ?? userData['user_id'] ?? '').toString(),
      name: userData['name'] as String?,
      email: userData['email'] as String?,
      mobile: userData['mobile'] as String?,
      token: token,
    );
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        mobile: mobile,
        token: token,
      );
}
