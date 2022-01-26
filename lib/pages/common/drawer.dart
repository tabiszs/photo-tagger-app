import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/data/auth_service.dart';
import 'package:photo_tagger/data/main_route_map.dart';
import 'package:photo_tagger/pages/authenticate/auth_cubit.dart';
import 'package:photo_tagger/pages/authenticate/sign_out_page.dart';
import 'package:provider/src/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);
  final _padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService(firebaseAuth: FirebaseAuth.instance);
    User user = authService.currentUser!;
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10),
            _buildHeader(
              url: user.photoURL,
              name: getName(user),
              email: getEmail(user),
            ),
            Container(
              padding: _padding,
              child: Column(
                children: [
                  _buildDivier(),
                  _buildMenuItem(
                    icon: Icons.add_photo_alternate_outlined,
                    text: 'Dodaj zdjęcia',
                    onClicked: () => _selectedItem(context, MainRoutingMap.addPhotosPage),
                  ),
                  _buildMenuItem(
                    icon: Icons.image_search_outlined,
                    text: 'Wyszukaj zdjęcia',
                  ),
                  // TODO - przeglądaj zdjęcia
                  // _buildMenuItem(
                  //   icon: Icons.photo_library_outlined,
                  //   text: 'Przeglądaj zdjęcia',
                  // ),
                  // TODO - edytuj zdjęcie
                  // _buildMenuItem(
                  //   icon: Icons.mode_edit_outlined,
                  //   text: 'Edytuj zdjęcie',
                  // ),
                  _buildMenuItem(
                      icon: Icons.folder_open_outlined,
                      text: 'Widok folderów',
                      onClicked: () => _selectedItem(context, MainRoutingMap.folderViewPage)),
                  _buildDivier(),
                  // TODO - ustawienia
                  // _buildMenuItem(
                  //   icon: Icons.settings,
                  //   text: 'Ustawienia',
                  // ),
                  _buildMenuItem(
                    icon: Icons.info_outlined,
                    text: 'O aplikacji',
                    onClicked: () => _selectedItem(context, MainRoutingMap.aboutAppPage),
                  ),
                  _buildMenuItem(
                    icon: Icons.logout_outlined,
                    text: 'Wyloguj',
                    onClicked: () {
                      context.read<AuthCubit>().signOut;
                      //_selectedItem(context, MainRoutingMap.loginPage);
                      //context.read<AuthService>().signOut;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getPhotoURL(User user) {
    const defaultPhotoURL = 'http://uigse-fse.org/wp-content/uploads/2019/08/croix-agse.png';
    if (user.photoURL == null) {
      return defaultPhotoURL;
    } else {
      return user.photoURL!;
    }
  }

  String getName(User user) {
    if (user.displayName == null) {
      return '';
    } else {
      return user.displayName!;
    }
  }

  String getEmail(User user) {
    if (user.email == null) {
      return '';
    } else {
      return user.email!;
    }
  }

  Widget _buildHeader({
    required String? url,
    required String name,
    required String email,
  }) {
    return Container(
      padding: _padding.add(const EdgeInsets.symmetric(vertical: 20)),
      child: Row(
        children: [
          //TODO - on Microsoft Account
          // CircleAvatar(
          //   radius: 30,
          //   backgroundImage: url == null ? null : NetworkImage(url),
          // ),
          // const SizedBox(width: 20),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO - on Microsoft Account
                // Text(
                //   name,
                //   overflow: TextOverflow.fade,
                //   softWrap: false,
                //   maxLines: 1,
                //   style: const TextStyle(fontSize: 20, color: Colors.white),
                // ),
                const SizedBox(height: 4),
                Text(
                  email,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDivier() {
    return const Divider(
      thickness: 1,
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    VoidCallback? onClicked,
  }) {
    //TODO - get colors from theme
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  //TODO zamienić na dziedziczenie
  void _selectedItem(BuildContext context, String path) {
    switch (path) {
      case MainRoutingMap.addPhotosPage:
        Navigator.of(context).pushNamed(MainRoutingMap.addPhotosPage);
        break;
      case MainRoutingMap.folderViewPage:
        Navigator.of(context).pushNamed(MainRoutingMap.folderViewPage);
        break;

      case MainRoutingMap.aboutAppPage:
        Navigator.of(context).pushNamed(MainRoutingMap.aboutAppPage);
        break;
      case MainRoutingMap.loginPage:
        Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
          builder: (BuildContext context) => const SignOutPage(),
        ));
        break;
    }
  }
}
