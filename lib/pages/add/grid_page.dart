import 'dart:io';

import 'package:flutter/material.dart';

class GridPage extends StatelessWidget {
  const GridPage({Key? key, required this.paths}) : super(key: key);

  final List<String> paths;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ...List.generate(paths.length, (index) {
                return PhotoTile(path: paths[index]);
              }),
            ],
          ),
        ],
      ),
    );
  }
}

//TODO - zrobić tak aby zdjęcia się powiększały i jeśli zmieści się dodatkowe zdjęcie to się pownownie zmiejszają do min rozmiaru tak aby kolejne zdjęcie w rzędzie się zmieściło
class PhotoTile extends StatelessWidget {
  const PhotoTile({
    Key? key,
    required this.path,
  }) : super(key: key);

  final double _radius = 9;
  final double _size = 150;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: Container(
          color: Colors.red,
          child: SizedBox.square(
            dimension: _size,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(_radius - 3),
                  child: Image(
                    image: FileImage(File(path)),
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        debugPrint('image loading null');
                        return child;
                      }
                      debugPrint('image loading...');
                      return const Center(child: CircularProgressIndicator());
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
