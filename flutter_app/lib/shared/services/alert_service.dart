import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/alert.dart';

final alertServiceProvider = Provider((ref) => AlertService());

class AlertService {
  Stream<List<Alert>> getActiveAlerts() {
    // Stub: Stream active alerts from Firestore
    return Stream.value([]);
  }

  Future<void> createAlert(Alert alert) async {
    // Stub: Save alert to Firestore and trigger Cloud Function for FCM
    await Future.delayed(const Duration(seconds: 1));
  }
}
