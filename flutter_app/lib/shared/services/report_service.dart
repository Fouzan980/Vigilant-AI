import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/report.dart';
import '../models/enums.dart';

final reportServiceProvider = Provider((ref) => ReportService());

class ReportService {
  Future<void> submitReport(Report report, List<String> localPhotoPaths) async {
    // Stub: Upload photos to Firebase Storage, then save report to Firestore
    await Future.delayed(const Duration(seconds: 1));
  }

  Stream<List<Report>> getReportsStream() {
    // Stub: Stream reports from Firestore
    return Stream.value([]);
  }

  Future<void> updateReportStatus(String reportId, ReportStatus status) async {
    // Stub: Update report status in Firestore
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
