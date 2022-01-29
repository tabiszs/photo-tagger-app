import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/pages/search/search_state.dart';
import 'package:photo_tagger/data/service/firestore_service.dart';
import 'package:photo_tagger/data/service/storage_service.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.firestore,
    required this.storage,
  }) : super(const InitialSearchState()) {}

  final FirestoreService firestore;
  final StorageService storage;
  final List<String> urls = [];
  static const Duration _minDuration = Duration(milliseconds: 500);

  void searchPhrase(String text) async {
    emit(const SearchingState());
    DateTime start = DateTime.now();

    urls.clear();
    List<String> paths = await firestore.find(text);
    var newUrls = await storage.getFilesFrom(paths);
    urls.addAll(newUrls);

    DateTime stop = DateTime.now();
    DateTime minTime = start.add(_minDuration);
    if (stop.isBefore(minTime)) {
      Future.delayed(
          Duration(milliseconds: minTime.millisecondsSinceEpoch - stop.millisecondsSinceEpoch));
    }
    emit(SearchResultState(urls: urls));
  }
}
