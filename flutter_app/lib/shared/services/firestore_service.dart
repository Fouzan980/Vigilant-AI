import 'package:cloud_firestore/cloud_firestore.dart';

/// Lightweight wrapper around Firestore for common CRUD and realtime streams.
class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService({FirebaseFirestore? instance})
    : _db = instance ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> collectionRef(String path) =>
      _db.collection(path);

  Stream<List<Map<String, dynamic>>> streamCollection(
    String path, {
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    Query<Map<String, dynamic>> query = collectionRef(path);
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
      (snap) => snap.docs.map((d) {
        final data = d.data();
        data['id'] = d.id;
        return data;
      }).toList(),
    );
  }

  Future<DocumentReference<Map<String, dynamic>>> add(
    String path,
    Map<String, dynamic> data,
  ) {
    return collectionRef(path).add(data);
  }

  Future<void> set(
    String path,
    String id,
    Map<String, dynamic> data, {
    bool merge = false,
  }) {
    return collectionRef(path).doc(id).set(data, SetOptions(merge: merge));
  }

  Future<void> delete(String path, String id) {
    return collectionRef(path).doc(id).delete();
  }

  Future<Map<String, dynamic>?> getById(String path, String id) async {
    final doc = await collectionRef(path).doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data();
    if (data == null) return null;
    data['id'] = doc.id;
    return data;
  }
}
