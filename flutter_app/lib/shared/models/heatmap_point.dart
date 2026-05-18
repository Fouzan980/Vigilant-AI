class HeatmapPoint {
  late double latitude;
  late double longitude;
  late double weight;
  late String category;

  HeatmapPoint();

  factory HeatmapPoint.fromJson(Map<String, dynamic> json) {
    return HeatmapPoint()
      ..latitude = json['latitude']
      ..longitude = json['longitude']
      ..weight = (json['weight'] as num).toDouble()
      ..category = json['category'];
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
