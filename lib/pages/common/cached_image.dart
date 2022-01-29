import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_tagger/common/loading_photo.dart';
import 'package:photo_tagger/data/utils/photo_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
          child: GestureDetector(
            onLongPress: () => saveImage(context, url),
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
      ),
    );
  }

  Future<void> saveImage(BuildContext context, String url) async {
    const snackBar = SnackBar(content: Text('Pobieram zdjęcie.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (await Vibrate.canVibrate) {
      var _type = FeedbackType.success;
      Vibrate.feedback(_type);
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;

    var file = await DefaultCacheManager().getSingleFile(url);
    String fileName = basename(file.path);
    await file.copy('$path/$fileName');
  }
}
