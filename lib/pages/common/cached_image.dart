import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/common/loading_photo.dart';
import 'package:photo_tagger/data/utils/photo_utils.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    required this.index,
    required this.url,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final int index;
  final String url;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: PhotoUtils.size,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(PhotoUtils.radius),
          child: IconButton(
            onPressed: () => onPressed,
            icon: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => const LoadingPhoto(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: PhotoUtils.size,
              height: PhotoUtils.size,
            ),
          ),
        ),
      ),
    );
  }
}
