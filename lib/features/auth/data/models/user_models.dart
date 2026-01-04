import 'package:scanner/features/auth/domain/entities/user_entity.dart';

class UserModels extends UserEntity{


  UserModels({
    required super.id,
    required super.email,
    required super.name,
    required super.phoneNumber,
  });
  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }
  Map<String, dynamic> json() {
    return {'email': email, 'id': id, 'name': name, 'phoneNumber': phoneNumber};
  }
}
