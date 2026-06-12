import 'enums.dart';
import '../utils/json_readers.dart';

class Alert {
  String id = '';
  String title = 'Alert';
  String subtitle = '';
  Severity severity = Severity.medium;
  double latitude = 0;
  double longitude = 0;
  double radius = 1000;
  String type = 'general';
  String createdBy = 'system';
  DateTime timestamp = DateTime.now();
  bool isActive = true;
  Audience targetAudience = Audience.public;

  Alert();

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert()
      ..id = json['id']?.toString() ?? ''
      ..title = json['title']?.toString() ?? 'Alert'
      ..subtitle = (json['subtitle'] ?? json['description'] ?? '').toString()
      ..severity = readEnum(Severity.values, json['severity'], Severity.medium)
      ..latitude = readDouble(json['latitude'])
      ..longitude = readDouble(json['longitude'])
      ..radius = readDouble(json['radius'], fallback: 1000)
      ..type = json['type']?.toString() ?? 'general'
      ..createdBy = json['createdBy']?.toString() ?? 'system'
      ..timestamp = readDateTime(json['timestamp'] ?? json['createdAt'])
      ..isActive = readBool(json['isActive'], fallback: true)
      ..targetAudience = readEnum(
        Audience.values,
        json['targetAudience'],
        Audience.public,
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'severity': severity.name,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'type': type,
      'createdBy': createdBy,
      'timestamp': timestamp.toIso8601String(),
      'isActive': isActive,
      'targetAudience': targetAudience.name,
    };
  }
}
