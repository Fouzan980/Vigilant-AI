import 'enums.dart';

class SafetyReport {
  late String id;
  late String userId;
  late double latitude;
  late double longitude;
  late FeelingType feelingType;
  late DateTime timestamp;
  late String description;

  SafetyReport();

  factory SafetyReport.fromJson(Map<String, dynamic> json) {
    return SafetyReport()
      ..id = json['id']
      ..userId = json['userId']
      ..latitude = json['latitude']
      ..longitude = json['longitude']
      ..feelingType = FeelingType.values.byName(json['feelingType'])
      ..timestamp = DateTime.parse(json['timestamp'])
      ..description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'feelingType': feelingType.name,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
    };
  }
}
