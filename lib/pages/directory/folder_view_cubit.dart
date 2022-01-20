import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/storage_service.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/directory/browse_states.dart';

class FolderViewCubit extends Cubit<BrowseState> {
  FolderViewCubit({required this.storage, required this.authCubit})
      : super(DirectoryBrowseState(pwd: '/'));

  final AuthCubit authCubit;
  final StorageService storage;
  late ListResult _refList;

  Future<ListResult> getFoldersAndFilesFrom(String fullPathFolder) async {
    _refList = await storage.listAllFolder(fullPathFolder);
    return _refList;
  }

  Future<List<String>> getUrlFiles() async {
    List<Reference> files = _refList.items;
    List<String> urls = [];
    for (int i = 0; i < files.length; ++i) {
      urls.add(await files[i].getDownloadURL());
    }
    return urls;
  }

  void startPhotoViewFrom(int index) {
    emit(PhotoBrowseState(index: index));
  }
}
