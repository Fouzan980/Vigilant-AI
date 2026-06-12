import 'enums.dart';
import '../utils/json_readers.dart';

class User {
  String id = '';
  String name = 'Unknown User';
  String email = '';
  UserRole role = UserRole.citizen;
  String district = 'Unknown';
  String phone = '';
  int reportsCount = 0;
  DateTime joinDate = DateTime.now();
  bool isActive = true;

  User();

  factory User.fromJson(Map<String, dynamic> json) {
    return User()
      ..id = json['id']?.toString() ?? ''
      ..name = json['name']?.toString() ?? 'Unknown User'
      ..email = json['email']?.toString() ?? ''
      ..role = readEnum(UserRole.values, json['role'], UserRole.citizen)
      ..district = json['district']?.toString() ?? 'Unknown'
      ..phone = json['phone']?.toString() ?? ''
      ..reportsCount = readInt(json['reportsCount'])
      ..joinDate = readDateTime(json['joinDate'] ?? json['createdAt'])
      ..isActive = readBool(json['isActive'], fallback: true);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'district': district,
      'phone': phone,
      'reportsCount': reportsCount,
      'joinDate': joinDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}
