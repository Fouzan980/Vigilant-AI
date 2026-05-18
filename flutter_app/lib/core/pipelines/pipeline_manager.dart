import '../../shared/services/firestore_service.dart';
import 'report_pipeline.dart';
import 'user_pipeline.dart';
import 'alert_pipeline.dart';

/// Manages app pipelines (reports, users, alerts) for Firestore-backed realtime flows.
class PipelineManager {
  final FirestoreService _firestore;

  late final ReportPipeline reports;
  late final UserPipeline users;
  late final AlertPipeline alerts;

  PipelineManager({FirestoreService? firestore})
    : _firestore = firestore ?? FirestoreService() {
    reports = ReportPipeline(_firestore);
    users = UserPipeline(_firestore);
    alerts = AlertPipeline(_firestore);
  }

  /// Dispose streams if pipelines expose controllers in future.
  void dispose() {
    // currently pipelines use Firestore streams directly; nothing to dispose
  }
}
