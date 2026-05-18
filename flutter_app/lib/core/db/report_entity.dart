import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// A simple report entity for offline queuing.
class ReportEntity {
  String? title;
  String? description;
  String? category;
  String? severity;
  bool isSynced = false;
  DateTime? createdAt;

  ReportEntity();

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'category': category,
    'severity': severity,
    'isSynced': isSynced,
    'createdAt': createdAt?.toIso8601String(),
  };

  factory ReportEntity.fromJson(Map<String, dynamic> json) {
    return ReportEntity()
      ..title = json['title']
      ..description = json['description']
      ..category = json['category']
      ..severity = json['severity']
      ..isSynced = json['isSynced'] ?? false
      ..createdAt = json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null;
  }
}

/// Lightweight local persistence using SharedPreferences (web-compatible).
class LocalDB {
  static const _key = 'offline_reports';
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveReport(ReportEntity report) async {
    final list = _getAll();
    list.add(report.toJson());
    await _prefs.setString(_key, jsonEncode(list));
  }

  static Future<List<ReportEntity>> getUnsyncedReports() async {
    return _getAll()
        .map((e) => ReportEntity.fromJson(e))
        .where((r) => !r.isSynced)
        .toList();
  }

  static List<Map<String, dynamic>> _getAll() {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(raw));
  }
}
