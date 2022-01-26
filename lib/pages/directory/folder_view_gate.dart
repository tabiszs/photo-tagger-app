import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/service/storage_service.dart';
import 'package:photo_tagger/data/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/common/app_view_scaffold.dart';
import 'package:photo_tagger/pages/common/bar.dart';
import 'package:photo_tagger/data/pages/directory/browse_states.dart';
import 'package:photo_tagger/pages/directory/details/details_browse_page.dart';
import 'package:photo_tagger/data/pages/directory/folder_view_cubit.dart';
import 'package:photo_tagger/pages/directory/folder/folder_view_page.dart';
import 'package:photo_tagger/pages/directory/photo/photo_view_page.dart';
import 'package:provider/provider.dart';

class FolderViewGate extends StatelessWidget {
  const FolderViewGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FolderViewCubit(
        storage: context.read<StorageService>(),
        authCubit: context.read<AuthCubit>(),
      ),
      child: BlocBuilder<FolderViewCubit, BrowseState>(
        builder: (context, state) {
          if (state is DirectoryBrowseState) {
            return AppViewScaffold(
              bodyWidget: Provider(
                create: (_) => state,
                child: const FolderViewPage(),
              ),
              bar: const MainBar(title: 'Wszystkie zdjęcia'),
            );
          } else if (state is DetailsBrowseState) {
            return const DetailsBrowsePage();
          } else {
            throw Exception('Unknown browse state');
          }
        },
      ),
    );
  }
}
