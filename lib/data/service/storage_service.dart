import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';

class StorageService {
  const StorageService({required storage}) : _storage = storage;

  final FirebaseStorage _storage;

  Future<String?> uploadFile(PhotoData data) async {
    File file = File(data.path);
    String name = nameInCloud(data);
    String path = pathInCloud(data, name);

    try {
      var referece = _storage.ref(path);
      await referece.putFile(file);
      return referece.fullPath;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  String nameInCloud(PhotoData data) {
    String fileNameWithExt = data.path.split('/').last;
    return DateTime.now().millisecondsSinceEpoch.toString() + '.' + fileNameWithExt;
  }

  String pathInCloud(PhotoData data, String name) {
    return '/' +
        (data.tags.branch ?? '') +
        '/' +
        (data.tags.activity ?? '') +
        '/' +
        (data.tags.author ?? '') +
        '/' +
        name;
  }

  Future<ListResult> listAllFolder(String fullPathFolder) async {
    ListResult result = await _storage.ref(fullPathFolder).listAll();
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

  Future<List<String>> getFilesFrom(List<String> paths) async {
    List<String> urls = [];
    for (int i = 0; i < paths.length; ++i) {
      String url = await _storage.ref(paths[i]).getDownloadURL();
      urls.add(url);
    }

    return urls;
  }
}
