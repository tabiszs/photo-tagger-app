import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_tagger/pages/add/add_photos_cubit.dart';
import 'package:photo_tagger/pages/add/data.dart';
import 'package:photo_tagger/pages/add/grid/loaded_photo.dart';
import 'package:photo_tagger/pages/add/grid/loading_photo.dart';
import 'package:provider/provider.dart';

class PhotoTile extends StatefulWidget {
  const PhotoTile({
    required this.photoData,
    Key? key,
  }) : super(key: key);

  final PhotoData photoData;
  @override
  State<PhotoTile> createState() => _PhotoTileState();
}

class _PhotoTileState extends State<PhotoTile> {
  late FileImage _image;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _image = FileImage(File(context.read<PhotoData>().path));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadImage();
  }

  void loadImage() async {
    await precacheImage(_image, context);
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: loaded ? LoadedPhoto(image: _image) : const LoadingPhoto(),
    );
  }
}
