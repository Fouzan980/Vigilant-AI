import 'enums.dart';
import '../utils/json_readers.dart';

class Report {
  String id = '';
  String userId = 'anonymous';
  String category = 'Other';
  String subcategory = '';
  Severity severity = Severity.medium;
  String description = '';
  double latitude = 0;
  double longitude = 0;
  String address = 'Unknown location';
  List<String> photoUrls = [];
  bool isAnonymous = false;
  Audience audience = Audience.public;
  ReportStatus status = ReportStatus.open;
  DateTime timestamp = DateTime.now();
  String? assignedOfficerId;

  Report();

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report()
      ..id = json['id']?.toString() ?? ''
      ..userId = json['userId']?.toString() ?? 'anonymous'
      ..category = json['category']?.toString() ?? 'Other'
      ..subcategory = json['subcategory']?.toString() ?? ''
      ..severity = readEnum(Severity.values, json['severity'], Severity.medium)
      ..description = json['description']?.toString() ?? ''
      ..latitude = readDouble(json['latitude'])
      ..longitude = readDouble(json['longitude'])
      ..address = (json['address'] ?? json['location'] ?? 'Unknown location')
          .toString()
      ..photoUrls = List<String>.from(json['photoUrls'] ?? [])
      ..isAnonymous = readBool(json['isAnonymous'])
      ..audience = readEnum(Audience.values, json['audience'], Audience.public)
      ..status = readEnum(
        ReportStatus.values,
        json['status'],
        ReportStatus.open,
      )
      ..timestamp = readDateTime(json['timestamp'] ?? json['createdAt'])
      ..assignedOfficerId = json['assignedOfficerId']?.toString();
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
