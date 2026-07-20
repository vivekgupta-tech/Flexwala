// features/auth/domain/entities/user_entity.dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? token;

  const UserEntity({
    required this.id,
    this.name,
    this.email,
    this.mobile,
    this.token,
  });

  @override
  List<Object?> get props => [id, name, email, mobile, token];
}

