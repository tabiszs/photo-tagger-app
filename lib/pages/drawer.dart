import 'package:flutter/material.dart';
import 'package:photo_tagger/data/main_route_map.dart';

import 'about/about_app_page.dart';
import 'add/add_photos_page.dart';
import 'authenticate/log_in_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);
  final _padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final name = 'Jan Kowalski Maria Winae';
    final email = 'jk@wp.pl-asssssssssssssssaaaaaaaa';
    //TODO - get propriate image from account
    final urlImage =
        'http://uigse-fse.org/wp-content/uploads/2019/08/croix-agse.png';

    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10),
            _buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
            ),
            Container(
              padding: _padding,
              child: Column(
                children: [
                  _buildDivier(),
                  _buildMenuItem(
                    icon: Icons.add_photo_alternate_outlined,
                    text: 'Dodaj zdjęcia',
                    onClicked: () =>
                        _selectedItem(context, MainRoutingMap.AddPhotosPage),
                  ),
                  _buildMenuItem(
                    icon: Icons.image_search_outlined,
                    text: 'Wyszukaj zdjęcia',
                  ),
                  _buildMenuItem(
                    icon: Icons.photo_library_outlined,
                    text: 'Przeglądaj zdjęcia',
                  ),
                  _buildMenuItem(
                    icon: Icons.mode_edit_outlined,
                    text: 'Edytuj zdjęcie',
                  ),
                  _buildMenuItem(
                    icon: Icons.folder_open_outlined,
                    text: 'Widok folderów',
                  ),
                  _buildDivier(),
                  _buildMenuItem(
                    icon: Icons.settings,
                    text: 'Ustawienia',
                  ),
                  _buildMenuItem(
                    icon: Icons.info_outlined,
                    text: 'O aplikacji',
                    onClicked: () =>
                        _selectedItem(context, MainRoutingMap.AboutAppPage),
                  ),
                  _buildMenuItem(
                    icon: Icons.logout_outlined,
                    text: 'Wyloguj',
                    onClicked: () =>
                        _selectedItem(context, MainRoutingMap.LoginPage),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({
    required String urlImage,
    required String name,
    required String email,
  }) {
    return Container(
      padding: _padding.add(const EdgeInsets.symmetric(vertical: 20)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(urlImage),
          ),
          const SizedBox(width: 20),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
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
      case MainRoutingMap.AddPhotosPage:
        Navigator.of(context).pushNamed(MainRoutingMap.AddPhotosPage);
        break;

      case MainRoutingMap.AboutAppPage:
        Navigator.of(context).pushNamed(MainRoutingMap.AboutAppPage);
        break;
      case MainRoutingMap.LoginPage:
        Navigator.of(context).pushNamed(MainRoutingMap.LoginPage);
        break;
    }
  }
}
