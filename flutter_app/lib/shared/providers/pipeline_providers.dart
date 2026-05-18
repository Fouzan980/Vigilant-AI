import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firestore_service.dart';
import '../../core/pipelines/pipeline_manager.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final pipelineManagerProvider = Provider<PipelineManager>((ref) {
  final fs = ref.watch(firestoreServiceProvider);
  return PipelineManager(firestore: fs);
});

final reportPipelineProvider = Provider(
  (ref) => ref.watch(pipelineManagerProvider).reports,
);
final userPipelineProvider = Provider(
  (ref) => ref.watch(pipelineManagerProvider).users,
);
final alertPipelineProvider = Provider(
  (ref) => ref.watch(pipelineManagerProvider).alerts,
);
