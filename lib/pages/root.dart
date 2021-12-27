import 'package:flutter/material.dart';
import 'package:photo_tagger/data/main_route_map.dart';
import 'package:photo_tagger/pages/about/about_app_page.dart';
import 'package:photo_tagger/pages/add/add_photos_page.dart';
import 'package:photo_tagger/pages/authenticate/log_in_page.dart';
import 'package:photo_tagger/pages/browse/browse_photos_page.dart';
import 'package:photo_tagger/pages/browse/search_photos_page.dart';
import 'package:photo_tagger/pages/directory/folder_view_page.dart';
import 'package:photo_tagger/pages/edit/edit_photo_page.dart';
import 'package:photo_tagger/pages/settings/settings_page.dart';

class PhotoTaggerApp extends StatelessWidget {
  const PhotoTaggerApp({Key? key}) : super(key: key);

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
      title: 'Photo tager',
      initialRoute: MainRoutingMap.AddPhotosPage,
      routes: {
        MainRoutingMap.AddPhotosPage: (context) => const AddPhotosPage(),
        MainRoutingMap.SearchPhotosPage: (context) => const SearchPhotosPage(),
        MainRoutingMap.BrowsePhotosPage: (context) => const BrowsePhotosPage(),
        MainRoutingMap.EditPhotosPage: (context) => const EditPhotoPage(),
        MainRoutingMap.FolderViewPage: (context) => const FolderViewPage(),
        MainRoutingMap.SeetingsPage: (context) => const SettingsPage(),
        MainRoutingMap.AboutAppPage: (context) => const AboutAppPage(),
        MainRoutingMap.LoginPage: (context) => const LogInPage(),
      },
    );
  }
}
