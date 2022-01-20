import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_tagger/common/loading_photo.dart';
import 'package:photo_tagger/data/photo_utils.dart';
import 'package:photo_tagger/pages/directory/browse_states.dart';
import 'package:photo_tagger/pages/directory/folder_view_cubit.dart';
import 'package:provider/src/provider.dart';

class FolderViewPage extends StatefulWidget {
  const FolderViewPage({Key? key}) : super(key: key);

  @override
  _FolderViewPageState createState() => _FolderViewPageState();
}

class _FolderViewPageState extends State<FolderViewPage> {
  static final double iconSize = PhotoUtils.size;
  static const double fontSize = 14;
  late ListResult _refList;
  late List<String> _urls;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getFoldersAndFiles();
  }

  void getFoldersAndFiles() async {
    String pwd = context.read<DirectoryBrowseState>().pwd;
    FolderViewCubit cubit = context.read<FolderViewCubit>();
    _refList = await cubit.getFoldersAndFilesFrom(pwd);
    _urls = await cubit.getUrlFiles();
    setState(() {
      loaded = true;
    });
  }

  void goToFolder(BuildContext context, String fullNameFolder) {
    context.read<DirectoryBrowseState>().pwd = fullNameFolder;
    setState(() => loaded = false);
    getFoldersAndFiles();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FolderViewPage()),
    );
  }

  void goToImageView(int index) {
    FolderViewCubit cubit = context.read<FolderViewCubit>();
    cubit.startPhotoViewFrom(index);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return loaded
          ? GridView(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                ...List.generate(_refList.prefixes.length, (index) {
                  return generateFolder(context, index);
                }),
                ...List.generate(_urls.length, (index) {
                  return generateImage(context, index);
                }),
              ],
            )
          : const Center(child: CircularProgressIndicator());
    });
  }

  Widget generateFolder(BuildContext context, int index) {
    return SizedBox.square(
      dimension: PhotoUtils.size,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: IconButton(
          onPressed: () => goToFolder(context, _refList.prefixes[index].fullPath),
          icon: Column(
            children: [
              Expanded(
                child: Icon(
                  Icons.folder_rounded,
                  color: Colors.grey,
                  size: iconSize - fontSize,
                ),
              ),
              Text(
                _refList.prefixes[index].name,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
                style: const TextStyle(fontSize: fontSize, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget generateImage(BuildContext context, int index) {
    return SizedBox.square(
      dimension: PhotoUtils.size,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(PhotoUtils.radius),
          child: IconButton(
            onPressed: () => goToImageView(index),
            icon: CachedNetworkImage(
              imageUrl: _urls[index],
              placeholder: (context, url) => const LoadingPhoto(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
