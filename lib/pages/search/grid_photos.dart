import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/common/loading_photo.dart';
import 'package:photo_tagger/data/utils/photo_utils.dart';
import 'package:photo_tagger/pages/common/cached_image.dart';
import 'package:photo_tagger/pages/directory/photo/photo_view_page.dart';

class GridPhotos extends StatelessWidget {
  const GridPhotos({required this.urls, Key? key}) : super(key: key);
  final List<String> urls;

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
        ...List.generate(
          urls.length,
          (index) {
            return CachedImage(
              index: index,
              url: urls[index],
              onPressed: () => goToImageView(context, index),
            );
          },
        ),
      ],
    );
  }

  void goToImageView(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PhotoViewPage(
          index: index,
          urls: urls,
        ),
      ),
    );
  }
}
