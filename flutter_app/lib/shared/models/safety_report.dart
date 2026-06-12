import 'enums.dart';
import '../utils/json_readers.dart';

class SafetyReport {
  String id = '';
  String userId = '';
  double latitude = 0;
  double longitude = 0;
  FeelingType feelingType = FeelingType.neutral;
  DateTime timestamp = DateTime.now();
  String description = '';

  SafetyReport();

  factory SafetyReport.fromJson(Map<String, dynamic> json) {
    return SafetyReport()
      ..id = json['id']?.toString() ?? ''
      ..userId = json['userId']?.toString() ?? ''
      ..latitude = readDouble(json['latitude'])
      ..longitude = readDouble(json['longitude'])
      ..feelingType = readEnum(
        FeelingType.values,
        json['feelingType'],
        FeelingType.neutral,
      )
      ..timestamp = readDateTime(json['timestamp'])
      ..description = json['description']?.toString() ?? '';
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
