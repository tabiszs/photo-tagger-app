import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/main_route_map.dart';
import 'package:photo_tagger/data/store_service.dart';

import 'settings/settings_page.dart';

import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:photo_tagger/pages/authenticate/sign_out_page.dart';
import 'package:photo_tagger/pages/browse/browse_photos_page.dart';
import 'package:photo_tagger/pages/browse/search_photos_page.dart';
import 'package:photo_tagger/pages/directory/folder_view_page.dart';
import 'package:photo_tagger/pages/edit/edit_photo_page.dart';
import 'package:photo_tagger/pages/authenticate/auth_state.dart';
import 'package:photo_tagger/data/main_route_map.dart';
import 'package:photo_tagger/pages/about/about_app_page.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:provider/provider.dart';

class AuthorizedRootPage extends StatelessWidget {
  const AuthorizedRootPage({
    Key? key,
    required this.signedInState,
  }) : super(key: key);

  final SignedInState signedInState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SignedInState>(create: (_) => signedInState),
        Provider<StoreService>(create: (_) => StoreService(storage: FirebaseStorage.instance)),
      ],
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.lightBlue[800],
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.black),
            )),
        title: 'Photo tager',
        initialRoute: MainRoutingMap.addPhotosPage,
        routes: {
          MainRoutingMap.addPhotosPage: (context) => const AddPhotosGate(),
          MainRoutingMap.searchPhotosPage: (context) => const SearchPhotosPage(),
          MainRoutingMap.browsePhotosPage: (context) => const BrowsePhotosPage(),
          MainRoutingMap.editPhotosPage: (context) => const EditPhotoPage(),
          MainRoutingMap.folderViewPage: (context) => const FolderViewPage(),
          MainRoutingMap.seetingsPage: (context) => const SettingsPage(),
          MainRoutingMap.aboutAppPage: (context) => const AboutAppPage(),
          MainRoutingMap.loginPage: (context) => const SignOutPage(),
        },
      ),
    );
  }
}
