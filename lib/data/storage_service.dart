import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<ListResult> listAllFolder(String fullPathFolder) async {
    ListResult result = await _storage.ref(fullPathFolder).listAll();

    for (var ref in result.items) {
      print('Found file: $ref');
    }

    for (var ref in result.prefixes) {
      print('Found directory: $ref');
    }
    return result;
  }

  Future<void> downloadFile(String fileName, String cloudPath) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/$fileName');

    try {
      await _storage.ref(cloudPath).writeToFile(downloadToFile);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled
    }
  }
}
