import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/messages.dart';
import 'package:photo_tagger/data/pages/search/search_cubit.dart';
import 'package:photo_tagger/data/pages/search/search_state.dart';
import 'package:photo_tagger/data/service/firestore_service.dart';
import 'package:photo_tagger/data/service/storage_service.dart';
import 'package:photo_tagger/pages/common/app_view_scaffold.dart';
import 'package:photo_tagger/pages/common/bar.dart';
import 'package:photo_tagger/pages/search/grid_photos.dart';
import 'package:photo_tagger/pages/search/search_widget.dart';

class SearchPhotosPage extends StatelessWidget {
  const SearchPhotosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(
        firestore: context.read<FirestoreService>(),
        storage: context.read<StorageService>(),
      ),
      child: AppViewScaffold(
        bar: MainBar(title: Msg.searchPhoto),
        bodyWidget: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          if (state is InitialSearchState) {
            return const SearchWidget();
          } else if (state is SearchingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchResultState) {
            return Column(
              children: [
                const SearchWidget(),
                Expanded(
                  child: GridPhotos(urls: context.read<SearchCubit>().urls),
                ),
              ],
            );
          } else {
            throw Exception('Unknown Search State');
          }
        }),
      ),
    );
  }
}
