import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_tagger/data/auth_service.dart';
import 'package:photo_tagger/data/main_route_map.dart';
import 'package:photo_tagger/pages/about/about_app_page.dart';
import 'package:photo_tagger/pages/add/add_photos_gate.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/auth_gate.dart';
import 'package:photo_tagger/pages/authenticate/sign_out_page.dart';
import 'package:photo_tagger/pages/browse/browse_photos_page.dart';
import 'package:photo_tagger/pages/browse/search_photos_page.dart';
import 'package:photo_tagger/pages/directory/folder_view_page.dart';
import 'package:photo_tagger/pages/edit/edit_photo_page.dart';
import 'package:provider/provider.dart';

import 'settings/settings_page.dart';

class PhotoTaggerApp extends StatelessWidget {
  const PhotoTaggerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AuthService(firebaseAuth: FirebaseAuth.instance),
      child: BlocProvider(
        create: (ctx) => AuthCubit(authService: ctx.read()),
        child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.lightBlue[800],
              textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.black),
              )),
          title: 'Photo tager',
          home: const AuthGate(),
          routes: {
            MainRoutingMap.AddPhotosPage: (context) => const AddPhotosGate(),
            MainRoutingMap.SearchPhotosPage: (context) => const SearchPhotosPage(),
            MainRoutingMap.BrowsePhotosPage: (context) => const BrowsePhotosPage(),
            MainRoutingMap.EditPhotosPage: (context) => const EditPhotoPage(),
            MainRoutingMap.FolderViewPage: (context) => const FolderViewPage(),
            MainRoutingMap.SeetingsPage: (context) => const SettingsPage(),
            MainRoutingMap.AboutAppPage: (context) => const AboutAppPage(),
            MainRoutingMap.LoginPage: (context) => const SignOutPage(),
          },
        ),
      ),
    );
  }
}
