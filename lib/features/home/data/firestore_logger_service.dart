import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreLoggerService {
  static int _readCount = 0;
  static int _writeCount = 0;

  static int get readCount => _readCount;
  static int get writeCount => _writeCount;

  static void resetCounters() {
    _readCount = 0;
    _writeCount = 0;
    debugPrint('Firestore counters reset');
  }

  static void logRead(String collection, {String? docId}) {
    _readCount++;
    debugPrint(
      'READ #$_readCount: $collection${docId != null ? '/$docId' : ''}',
    );
  }

  static void logWrite(
    String collection, {
    String? docId,
    String operation = 'write',
  }) {
    _writeCount++;
    debugPrint(
      'WRITE #$_writeCount: $operation on $collection${docId != null ? '/$docId' : ''}',
    );
  }

  static void printSummary() {
    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('FIRESTORE OPERATIONS SUMMARY');
    debugPrint('═══════════════════════════════════════');
    debugPrint('Total Reads:  $_readCount');
    debugPrint('Total Writes: $_writeCount');
    debugPrint('Total Ops:    ${_readCount + _writeCount}');
    debugPrint('═══════════════════════════════════════');
    debugPrint('');
  }
}

extension FirestoreLogging on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> collectionWithLogging(String path) {
    return collection(path);
  }

  Future<DocumentReference<Map<String, dynamic>>> addWithLogging(
    String collection,
    Map<String, dynamic> data,
  ) async {
    FirestoreLoggerService.logWrite(collection, operation: 'add');
    return this.collection(collection).add(data);
  }

  Future<void> setWithLogging(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    FirestoreLoggerService.logWrite(collection, docId: docId, operation: 'set');
    return this.collection(collection).doc(docId).set(data);
  }

  Future<void> updateWithLogging(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    FirestoreLoggerService.logWrite(
      collection,
      docId: docId,
      operation: 'update',
    );
    return this.collection(collection).doc(docId).update(data);
  }

  Future<void> deleteWithLogging(String collection, String docId) async {
    FirestoreLoggerService.logWrite(
      collection,
      docId: docId,
      operation: 'delete',
    );
    return this.collection(collection).doc(docId).delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocWithLogging(
    String collection,
    String docId,
  ) async {
    FirestoreLoggerService.logRead(collection, docId: docId);
    return this.collection(collection).doc(docId).get();
  }
}

extension QueryLogging on Query<Map<String, dynamic>> {
  Future<QuerySnapshot<Map<String, dynamic>>> getWithLogging(
    String collectionName,
  ) async {
    final snapshot = await get();
    FirestoreLoggerService.logRead(
      collectionName,
      docId: '${snapshot.docs.length} docs',
    );
    return snapshot;
  }
}

extension StreamLogging on Stream<QuerySnapshot<Map<String, dynamic>>> {
  Stream<QuerySnapshot<Map<String, dynamic>>> withLogging(
    String collectionName,
  ) {
    return map((snapshot) {
      FirestoreLoggerService.logRead(
        collectionName,
        docId: '${snapshot.docs.length} docs (stream)',
      );
      return snapshot;
    });
  }
}
