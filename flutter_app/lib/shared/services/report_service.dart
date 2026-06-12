import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/report.dart';
import '../models/enums.dart';
import '../providers/pipeline_providers.dart';
import '../../core/pipelines/report_pipeline.dart';

final reportServiceProvider = Provider(
  (ref) => ReportService(ref.watch(reportPipelineProvider)),
);

class ReportService {
  final ReportPipeline _pipeline;

  ReportService(this._pipeline);

  Future<void> submitReport(Report report, List<String> localPhotoPaths) async {
    final data = report.toJson();
    data.removeWhere((key, value) => value == null);
    data['localPhotoPaths'] = localPhotoPaths;

    if (report.id.isEmpty) {
      await _pipeline.add(data);
    } else {
      await _pipeline.set(report.id, data, merge: true);
    }
  }

  Stream<List<Report>> getReportsStream() {
    return _pipeline.streamAll().map(
      (items) => items.map((item) => Report.fromJson(item)).toList(),
    );
  }

  Future<void> updateReportStatus(String reportId, ReportStatus status) async {
    await _pipeline.set(reportId, {'status': status.name}, merge: true);
  }
}
