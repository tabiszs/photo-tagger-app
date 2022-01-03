import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/grid/photo_tile.dart';
import 'package:photo_tagger/pages/add/tile/data.dart';
import 'package:provider/provider.dart';

class GridPage extends StatefulWidget {
  const GridPage({Key? key, required this.datas}) : super(key: key);

  final List<PhotoData> datas;

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        ...List.generate(widget.datas.length, (index) {
          return Provider(
            create: (_) => widget.datas[index],
            child: const PhotoTile(),
          );
        }),
      ],
    );
  }
}
