import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_tagger/data/info/tag_info.dart';
import 'package:photo_tagger/pages/add/details/tagger_form_page.dart';

class GridPage extends StatelessWidget {
  const GridPage({Key? key, required this.paths}) : super(key: key);

  final List<String> paths;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          ...List.generate(paths.length, (index) {
            return PhotoTile(path: paths[index]);
          }),
        ],
      ),
    );
  }
}

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
      child: IconButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TaggerFormPage(
            tagInfo: TagInfo(),
          );
        })),
        // onLongPress: //TODO - możliwe grupowanie: tagowania lub usuwania,
        icon: ClipRRect(
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
      ),
    );
  }
}
