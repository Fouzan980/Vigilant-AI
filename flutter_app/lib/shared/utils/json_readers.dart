import 'package:cloud_firestore/cloud_firestore.dart';

DateTime readDateTime(dynamic value, {DateTime? fallback}) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value) ?? fallback ?? DateTime.now();
  }
  return fallback ?? DateTime.now();
}

double readDouble(dynamic value, {double fallback = 0}) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? fallback;
  return fallback;
}

int readInt(dynamic value, {int fallback = 0}) {
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}

bool readBool(dynamic value, {bool fallback = false}) {
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  return fallback;
}

T readEnum<T extends Enum>(List<T> values, dynamic value, T fallback) {
  final normalized = value?.toString().replaceAll(' ', '').toLowerCase();
  if (normalized == null || normalized.isEmpty) return fallback;

  return values.firstWhere(
    (item) => item.name.toLowerCase() == normalized,
    orElse: () => fallback,
  );
}
