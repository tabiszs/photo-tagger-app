import 'package:flutter/material.dart';

class MainBar extends StatelessWidget implements PreferredSizeWidget {
  const MainBar({required this.title, Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
