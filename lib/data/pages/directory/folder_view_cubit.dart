import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/service/storage_service.dart';
import 'package:photo_tagger/data/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/data/pages/directory/browse_states.dart';

class FolderViewCubit extends Cubit<BrowseState> {
  FolderViewCubit({required this.storage, required this.authCubit})
      : super(DirectoryBrowseState(pwd: '/'));

  final AuthCubit authCubit;
  final StorageService storage;
  late ListResult _refList;
  late List<String> urls;

  Future<ListResult> getFoldersAndFilesFrom(String fullPathFolder) async {
    _refList = await storage.listAllFolder(fullPathFolder);
    return _refList;
  }

  Future<List<String>> getUrlFiles() async {
    List<Reference> files = _refList.items;
    urls = [];
    for (int i = 0; i < files.length; ++i) {
      String url = await files[i].getDownloadURL();
      authCubit.addCachedImage(url);
      urls.add(url);
    }
    return urls;
  }

  void startPhotoViewFrom(int index) {
    emit(PhotoBrowseState(index: index));
  }

  bool isBranchFolder(String path) {
    return path != '/';
  }

  String goToParentOf(String path) {
    int lastSlash = path.lastIndexOf('/');
    if (lastSlash < 0) {
      return '/';
    }
    return path.substring(0, lastSlash);
  }
}
