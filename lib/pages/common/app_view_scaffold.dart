import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/common/drawer.dart';

class AppViewScaffold extends StatelessWidget {
  const AppViewScaffold({
    Key? key,
    required this.bodyWidget,
    this.actionPanel,
    required this.bar,
  }) : super(key: key);
  final Widget bodyWidget;
  final Widget? actionPanel;
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
