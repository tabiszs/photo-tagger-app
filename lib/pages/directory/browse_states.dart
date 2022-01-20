import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_tagger/data/info/tag_info.dart';

abstract class BrowseState {
  const BrowseState();
}

class DirectoryBrowseState extends BrowseState {
  DirectoryBrowseState({required this.pwd});

  String pwd;
}

class PhotoBrowseState extends BrowseState {
  PhotoBrowseState({required this.index});

  int index;
}

class DetailsBrowseState extends BrowseState {
  DetailsBrowseState({required this.ref, required this.tag});

  Reference ref;
  TagInfo tag;
}

class SearchBrowseState extends BrowseState {
  const SearchBrowseState();
}
