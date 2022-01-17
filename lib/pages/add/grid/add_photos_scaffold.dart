import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/bar.dart';
import 'package:photo_tagger/pages/drawer.dart';

class AddPhotosScaffold extends StatelessWidget {
  const AddPhotosScaffold({
    Key? key,
    required this.bodyWidget,
    required this.actionPanel,
    required this.bar,
  }) : super(key: key);
  final Widget bodyWidget;
  final Widget actionPanel;
  final PreferredSizeWidget bar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: bar,
      body: bodyWidget,
      floatingActionButton: actionPanel,
    );
  }
}
