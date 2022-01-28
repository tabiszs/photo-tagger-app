import 'package:flutter/material.dart';
import 'package:photo_tagger/data/photo/photo_data.dart';
import 'package:photo_tagger/pages/add/grid/tile/photo_tile.dart';
import 'package:provider/provider.dart';

class GridPage extends StatelessWidget {
  const GridPage({Key? key, required this.datas}) : super(key: key);
  final List<PhotoData> datas;

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
        ...List.generate(datas.length, (index) {
          return Provider(
            create: (_) => datas[index],
            child: PhotoTile(photoData: datas[index]),
          );
        }),
      ],
    );
  }
}
