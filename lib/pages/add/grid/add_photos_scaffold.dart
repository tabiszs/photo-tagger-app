import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/bar.dart';
import 'package:photo_tagger/pages/drawer.dart';

class AddPhotosScaffold extends StatelessWidget {
  const AddPhotosScaffold({
    Key? key,
    required this.bodyWidget,
    required this.actionPanel,
  }) : super(key: key);
  final Widget bodyWidget;
  final Widget actionPanel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: const MainBar(title: 'Dodawanie zdjęć'),
      body: bodyWidget,
      floatingActionButton: actionPanel,
    );
  }
}
