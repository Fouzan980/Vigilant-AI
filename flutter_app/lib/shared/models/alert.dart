import 'enums.dart';

class Alert {
  late String id;
  late String title;
  late String subtitle;
  late Severity severity;
  late double latitude;
  late double longitude;
  late double radius;
  late String type;
  late String createdBy;
  late DateTime timestamp;
  late bool isActive;
  late Audience targetAudience;

  Alert();

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert()
      ..id = json['id']
      ..title = json['title']
      ..subtitle = json['subtitle']
      ..severity = Severity.values.byName(json['severity'])
      ..latitude = json['latitude']
      ..longitude = json['longitude']
      ..radius = (json['radius'] as num).toDouble()
      ..type = json['type']
      ..createdBy = json['createdBy']
      ..timestamp = DateTime.parse(json['timestamp'])
      ..isActive = json['isActive']
      ..targetAudience = Audience.values.byName(json['targetAudience']);
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
