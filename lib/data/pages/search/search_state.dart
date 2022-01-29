
abstract class SearchState {
  const SearchState();
}

class InitialSearchState extends SearchState {
  const InitialSearchState();
}

class SearchingState extends SearchState {
  const SearchingState();
}

class SearchResultState extends SearchState {
  const SearchResultState({required this.urls});

  final List<String> urls;
}
