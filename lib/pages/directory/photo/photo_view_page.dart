import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_tagger/common/loading_photo.dart';
import 'package:photo_tagger/pages/directory/browse_states.dart';
import 'package:photo_tagger/pages/directory/folder_view_cubit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/src/provider.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({Key? key}) : super(key: key);

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  static final transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    final FolderViewCubit cubit = context.read<FolderViewCubit>();
    final int currIdx = context.read<PhotoBrowseState>().index;
    final PageController controller = PageController(initialPage: currIdx);
    final List<String> urls = cubit.urls;

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
