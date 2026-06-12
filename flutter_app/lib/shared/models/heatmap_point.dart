import '../utils/json_readers.dart';

class HeatmapPoint {
  double latitude = 0;
  double longitude = 0;
  double weight = 1;
  String category = 'unknown';

  HeatmapPoint();

  factory HeatmapPoint.fromJson(Map<String, dynamic> json) {
    return HeatmapPoint()
      ..latitude = readDouble(json['latitude'])
      ..longitude = readDouble(json['longitude'])
      ..weight = readDouble(json['weight'], fallback: 1)
      ..category = json['category']?.toString() ?? 'unknown';
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'weight': weight,
      'category': category,
    };
  }
}
