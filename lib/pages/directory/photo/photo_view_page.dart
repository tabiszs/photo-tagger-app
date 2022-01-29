import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({
    required this.index,
    required this.urls,
    Key? key,
  }) : super(key: key);
  final int index;
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: index);

    return PageView(
      controller: controller,
      children: [
        ...List.generate(urls.length, (index) {
          return SafeArea(
            child: Center(
              child: Expanded(
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(urls[index]),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.8,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
