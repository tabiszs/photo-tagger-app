import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_tagger/pages/add/data.dart';

class StoreService {
  const StoreService({required storage}) : _storage = storage;

  final FirebaseStorage _storage;

  Future<void> uploadFile(PhotoData data) async {
    File file = File(data.path);

    try {
      await _storage.ref(data.tags.branch).putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      rethrow;
    }
  }
}
