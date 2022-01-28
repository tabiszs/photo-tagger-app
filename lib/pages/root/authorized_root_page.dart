import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:photo_tagger/data/pages/authenticate/auth_state.dart';
import 'package:photo_tagger/pages/browse/browse_photos_page.dart';
import 'package:photo_tagger/pages/browse/search_photos_page.dart';
import 'package:photo_tagger/pages/directory/folder_view_gate.dart';
import 'package:photo_tagger/pages/edit/edit_photo_page.dart';
import 'package:photo_tagger/pages/about/about_app_page.dart';
import 'package:photo_tagger/pages/settings/settings_page.dart';
import 'package:photo_tagger/data/utils/main_route_map.dart';
import 'package:provider/provider.dart';

class AuthorizedRootPage extends StatelessWidget {
  const AuthorizedRootPage({
    required this.signedInState,
    Key? key,
  }) : super(key: key);

  final SignedInState signedInState;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => signedInState,
      child: MaterialApp(
        initialRoute: MainRoutingMap.addPhotosPage,
        routes: {
          MainRoutingMap.addPhotosPage: (context) => const AddPhotosGate(),
          MainRoutingMap.searchPhotosPage: (context) => const SearchPhotosPage(),
          MainRoutingMap.browsePhotosPage: (context) => const BrowsePhotosPage(),
          MainRoutingMap.editPhotosPage: (context) => const EditPhotoPage(),
          MainRoutingMap.folderViewPage: (context) => const FolderViewGate(),
          MainRoutingMap.seetingsPage: (context) => const SettingsPage(),
          MainRoutingMap.aboutAppPage: (context) => const AboutAppPage(),
        },
      ),
    );
  }
}
