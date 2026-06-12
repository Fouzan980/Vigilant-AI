import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/alert.dart';
import '../providers/pipeline_providers.dart';
import '../../core/pipelines/alert_pipeline.dart';

final alertServiceProvider = Provider(
  (ref) => AlertService(ref.watch(alertPipelineProvider)),
);

class AlertService {
  final AlertPipeline _pipeline;

  AlertService(this._pipeline);

  Stream<List<Alert>> getActiveAlerts() {
    return _pipeline.streamAll().map(
      (items) => items
          .map((item) => Alert.fromJson(item))
          .where((alert) => alert.isActive)
          .toList(),
    );
  }

  Future<void> createAlert(Alert alert) async {
    final data = alert.toJson();
    if (alert.id.isEmpty) {
      await _pipeline.add(data);
    } else {
      await _pipeline.set(alert.id, data, merge: true);
    }
  }
}
