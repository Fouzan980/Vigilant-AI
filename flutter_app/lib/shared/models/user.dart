import 'enums.dart';

class User {
  late String id;
  late String name;
  late String email;
  late UserRole role;
  late String district;
  late String phone;
  late int reportsCount;
  late DateTime joinDate;
  late bool isActive;

  User();

  factory User.fromJson(Map<String, dynamic> json) {
    return User()
      ..id = json['id']
      ..name = json['name']
      ..email = json['email']
      ..role = UserRole.values.byName(json['role'])
      ..district = json['district']
      ..phone = json['phone']
      ..reportsCount = json['reportsCount']
      ..joinDate = DateTime.parse(json['joinDate'])
      ..isActive = json['isActive'];
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
