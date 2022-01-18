import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_tagger/data/data.dart';

class StorageService {
  const StorageService({required storage}) : _storage = storage;

  final FirebaseStorage _storage;

  Future<void> uploadFile(PhotoData data) async {
    File file = File(data.path);
    String fileNameWithExt = data.path.split('/').last;
    String nameInCloud = DateTime.now().millisecondsSinceEpoch.toString() + '.' + fileNameWithExt;
    // String pathInCloud = '/' +
    //     (data.tags.branch ?? '') +
    //     '/' +
    //     (data.tags.activity ?? '') +
    //     '/' +
    //     (data.tags.place ?? '') +
    //     '/' +
    //     (data.tags.author ?? '') +
    //     '/' +
    //     nameInCloud;

    try {
      await _storage.ref(/*pathInCloud*/ nameInCloud).putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      rethrow;
    }
  }
}
