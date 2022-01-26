import 'package:flutter/material.dart';
import 'package:photo_tagger/data/main_route_map.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:photo_tagger/pages/authenticate/auth_gate.dart';
import 'package:photo_tagger/pages/authenticate/sign_out_page.dart';
import 'package:photo_tagger/pages/browse/browse_photos_page.dart';
import 'package:photo_tagger/pages/browse/search_photos_page.dart';
import 'package:photo_tagger/pages/directory/folder_view_gate.dart';
import 'package:photo_tagger/pages/edit/edit_photo_page.dart';
import 'package:photo_tagger/pages/about/about_app_page.dart';
import 'package:photo_tagger/pages/settings/settings_page.dart';

class RootAppPage extends StatelessWidget {
  const RootAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.black),
          )),
      title: 'Biblioteka Zdjęć',
      home: const AuthGate(),
      // initialRoute: MainRoutingMap.loginPage,
      // routes: {
      //   MainRoutingMap.addPhotosPage: (context) => const AddPhotosGate(),
      //   MainRoutingMap.searchPhotosPage: (context) => const SearchPhotosPage(),
      //   MainRoutingMap.browsePhotosPage: (context) => const BrowsePhotosPage(),
      //   MainRoutingMap.editPhotosPage: (context) => const EditPhotoPage(),
      //   MainRoutingMap.folderViewPage: (context) => const FolderViewGate(),
      //   MainRoutingMap.seetingsPage: (context) => const SettingsPage(),
      //   MainRoutingMap.aboutAppPage: (context) => const AboutAppPage(),
      //   MainRoutingMap.loginPage: (context) => const SignOutPage(),
      // },
    );
  }
}
