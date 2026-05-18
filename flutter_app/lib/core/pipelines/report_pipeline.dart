import '../../shared/services/firestore_service.dart';

class ReportPipeline {
  final FirestoreService _fs;
  final String collection = 'reports';

  ReportPipeline(this._fs);

  Stream<List<Map<String, dynamic>>> streamAll() =>
      _fs.streamCollection(collection);

  Future<Map<String, dynamic>?> getById(String id) =>
      _fs.getById(collection, id);

  Future<String> add(Map<String, dynamic> data) async {
    final ref = await _fs.add(collection, data);
    return ref.id;
  }

  Future<void> set(
    String id,
    Map<String, dynamic> data, {
    bool merge = false,
  }) => _fs.set(collection, id, data, merge: merge);

  Future<void> delete(String id) => _fs.delete(collection, id);
}
