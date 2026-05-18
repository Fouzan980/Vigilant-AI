import 'enums.dart';

class Report {
  late String id;
  late String userId;
  late String category;
  late String subcategory;
  late Severity severity;
  late String description;
  late double latitude;
  late double longitude;
  late String address;
  late List<String> photoUrls;
  late bool isAnonymous;
  late Audience audience;
  late ReportStatus status;
  late DateTime timestamp;
  String? assignedOfficerId;

  Report();

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report()
      ..id = json['id']
      ..userId = json['userId']
      ..category = json['category']
      ..subcategory = json['subcategory']
      ..severity = Severity.values.byName(json['severity'])
      ..description = json['description']
      ..latitude = json['latitude']
      ..longitude = json['longitude']
      ..address = json['address']
      ..photoUrls = List<String>.from(json['photoUrls'] ?? [])
      ..isAnonymous = json['isAnonymous']
      ..audience = Audience.values.byName(json['audience'])
      ..status = ReportStatus.values.byName(json['status'])
      ..timestamp = DateTime.parse(json['timestamp'])
      ..assignedOfficerId = json['assignedOfficerId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'category': category,
      'subcategory': subcategory,
      'severity': severity.name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'photoUrls': photoUrls,
      'isAnonymous': isAnonymous,
      'audience': audience.name,
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'assignedOfficerId': assignedOfficerId,
    };
  }
}
